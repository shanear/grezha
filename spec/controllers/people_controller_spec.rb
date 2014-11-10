require 'spec_helper'

describe Api::V1::PeopleController do
  let(:organization) { Organization.create!(name: "Lil Org") }

  let(:user) {
    FactoryGirl.create(:user, organization_id: organization.id)
  }

  describe "while logged in" do
    before { auth_with_user(user) }

    let(:person) {
      FactoryGirl.create(:person,
        name: "Brian",
        organization_id: organization.id)
    }

    let(:other_person) {
      FactoryGirl.create(:person, organization_id: organization.id + 1)
    }

    describe "GET #index" do
      it "gets all people in user's organization" do
        person; other_person;
        get :index, format: :json

        expect(json["people"].length).to eq(1)
        expect(json["people"].first["name"]).to eq("Brian")
      end
    end

    describe "GET #show" do
      it "returns person by remote_id" do
        get :show, id: person.remote_id, format: :json
        expect(json["person"]["id"]).to eq(person.remote_id)
        expect(json["person"]["name"]).to eq("Brian")
      end

      it "returns person by id" do
        get :show, id: person.id, format: :json
        expect(json["person"]["id"]).to eq(person.remote_id)
        expect(json["person"]["name"]).to eq("Brian")
      end

      it "doesn't return people not in organization" do
        expect {
          get :show, id: other_person.id, format: :json
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "POST #create" do
      it "creates person in user's organization" do
        post :create,
          {
            id: person.remote_id,
            person: {
              id: "ABCDEFGH",
              name: "Cindy",
              role: "teacher",
              notes: "She's great",
              contact_info: "132-1345",
              organization_id: organization.id + 1
            }
          },
          format: :json

        expect(json["person"]["id"]).to eq("ABCDEFGH")
        expect(json["person"]["name"]).to eq("Cindy")
        expect(json["person"]["contact_info"]).to eq("132-1345")
        expect(json["person"]["notes"]).to eq("She's great")
        expect(json["person"]["role"]).to eq("teacher")

        new_person =Person.where(remote_id: "ABCDEFGH").first
        expect(new_person.organization_id).to eq(organization.id)
      end
    end

    describe "POST #update" do
      it "updates person by remote_id" do
        post :update,
          { id: person.remote_id, person: {name: "Cranston"} },
          format: :json

        expect(json["person"]["name"]).to eq("Cranston")
        expect(Person.find(person.id).name).to eq("Cranston")
      end

      it "only updates permitted attributes" do
        remote_id = person.remote_id

        post :update,
          {
            id: person.remote_id,
            person: {remote_id: "HAXXORZ", organization_id: 10101}
          },
          format: :json

        updated_person = Person.find(person.id)
        expect(updated_person.remote_id).to eq(remote_id)
        expect(updated_person.organization_id).to eq(organization.id)
      end

      it "doesn't update people not in organization" do
        expect {
          post :update,
            {id: other_person.remote_id, person: {name: "Cranston"}},
            format: :json
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
