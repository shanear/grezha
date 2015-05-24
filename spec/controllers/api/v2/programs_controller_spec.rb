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

    describe "GET #index" do
      before { [program, other_program] }

      it "gets programs for the user's organization" do
        get :index, format: :json

        expect(json["programs"].length).to be(1)
        expect(json["programs"].first["name"]).to eq("Moving Club")
      end
    end
  end
end