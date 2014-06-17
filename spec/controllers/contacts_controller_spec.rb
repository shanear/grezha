require 'spec_helper'

describe Api::V1::ContactsController do
  let(:organization) { Organization.create!(name: "Lil Org") }
  let(:user) { FactoryGirl.create(:user, organization_id: organization.id) }

  describe "while logged in" do
    before { auth_with_user(user) }

    let(:contact) {
      FactoryGirl.create(:contact, name: "Billy", organization_id: organization.id)
    }

    let(:other_contact) {
      FactoryGirl.create(:contact, name: "Other person", organization_id: organization.id + 1)
    }

    describe "GET #index" do
      before { [contact, other_contact] }

      it "gets contacts for the user's organization" do
        get :index, format: :json

        expect(json["contacts"].length).to be(1)
        expect(json["contacts"].first["name"]).to eq("Billy")
      end
    end

    describe "GET #show" do
      it "returns contact data" do
        get :show, id: contact.id, format: :json
        expect(json["contact"]["name"]).to eq("Billy")
      end

      it "fails if contact not in organization" do
        expect {
          get :show, id: other_contact.id, format: :json
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "POST #create" do
      it "creates a new contact in user's organization with a remote id" do
        post :create, contact: { name: "Joe Bob" }

        new_contact = Contact.last
        expect(new_contact.name).to eq("Joe Bob")
        expect(new_contact.remote_id).to match(/[a-zA-Z0-9]{8}/)
        expect(new_contact.organization_id).to eq(organization.id)
      end
    end

    describe "PUT #update" do
      it "updates contact" do
        put :update, id: contact.id, contact: { name: "New Billy" }, format: :json

        updated_contact = Contact.find(contact.id)
        expect(updated_contact.name).to eq("New Billy")
      end

      it "fails if contact not in organization" do
        expect {
          put :update, id: other_contact.id, contact: { name: "New Billy" }, format: :json
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "DELETE #destroy" do
      it "deletes contact" do
        delete :destroy, id: contact.id, format: :json

        expect(Contact.exists?(contact.id)).to be_false
      end

      it "fails if contact not in organization" do
        expect {
          delete :destroy, id: other_contact.id, format: :json
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end