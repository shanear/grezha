require 'spec_helper'

describe Api::V1::RelationshipsController do

  let(:organization) { Organization.create!(name: "Bama Club") }
  let(:user) { FactoryGirl.create(:user, organization_id: organization.id) }
   describe "while logged in" do
    before { auth_with_user(user) }
    let(:contact) {relationship.contact}
    let(:relationship) {
    	FactoryGirl.create(:relationship, name: "a probation officer",organization_id: organization.id)
    }
    let(:other_relationship) {
    	FactoryGirl.create(:relationship, name: "a different probation officer", organization_id: organization.id+1 )
    }

	     describe "GET #index" do
	      before { [relationship, other_relationship] }

	      it "gets connections for the user's organization" do
	        get :index, format: :json

	        expect(json["relationships"].length).to eq(1)
	        expect(json["relationships"].first["name"]).to eq(relationship.name)
	      end
	    end

      describe "GET #show" do
        it "returns connection data" do
          get :show, id: relationship.id, format: :json
          expect(json["relationship"]["name"]).to eq("a probation officer")
        end

        it "fails if contact not in organization" do
          expect {
            get :show, id: other_relationship.id, format: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end

      end

      describe "POST #create" do
        it "creates a new connection in user's organization with a remote id" do
          post :create, relationship: { name: "Howey", contact_id: contact.id , relationship_type: "officer"}
          new_relationship = Relationship.last
          expect(new_relationship.name).to eq("Howey")
          expect(new_relationship.remote_id).to match(/[a-zA-Z0-9]{8}/)
          expect(new_relationship.organization_id).to eq(organization.id)
        end
      end

      describe "DELETE #destroy" do
        it "deletes connection" do
          delete :destroy, id: relationship.id, format: :json

          expect(Relationship.exists?(relationship.id)).to be_false
        end

        it "fails if contact not in organization" do
          expect {
            delete :destroy, id: other_relationship.id, format: :json
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

	end
end