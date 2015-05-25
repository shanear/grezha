require 'spec_helper'

describe Api::V2::ProgramsController do
  let(:organization) { Organization.create!(name: "Lucas Bro's Moving Co") }
  let(:user) {
    FactoryGirl.create(:user,
      name: "Kenny",
      organization_id: organization.id)
  }


  describe "while logged in" do
    before { authorize_api(user) }

    describe "GET #index" do
      let(:program) {
        FactoryGirl.create(:program,
          name: "Moving Club",
          organization_id: organization.id
        )
      }

      let(:other_program) {
        FactoryGirl.create(:program,
          name: "Anti-Moving Club",
          organization_id: organization.id + 1
        )
      }

      it "gets programs for the user's organization" do
        [program, other_program]
        get :index, format: :json

        expect(json["programs"].length).to be(1)
        expect(json["programs"].first["name"]).to eq("Moving Club")
      end
    end

    describe "POST #create" do
      it "creates a new event in user's organization with a remote id" do
        post :create, program: {
          id: "ABCDEFG1",
          name: "Book club"
        }

        new_program = Program.last
        expect(new_program.remote_id).to eq("ABCDEFG1")
        expect(new_program.organization_id).to eq(organization.id)
        expect(new_program.name).to eq("Book club")
      end
    end
  end
end