require 'spec_helper'

describe Api::V2::ContactsController do
  let(:organization) { Organization.create!(name: "Lil Org") }
  let(:user) { FactoryGirl.create(:user, name: "Shophie", organization_id: organization.id) }

  describe "while logged in" do
    before { authorize_api(user) }

    let(:client) {
      FactoryGirl.create(:contact,
        name: "Billy",
        role: "client",
        organization_id: organization.id
      )
    }

    let(:other_client) {
      FactoryGirl.create(:contact,
        name: "Stan",
        role: "client",
        organization_id: organization.id + 1
      )
    }

    describe "GET #index" do
      before { [client, other_client] }

      it "gets contacts for the user's organization" do
        get :index, format: :json

        expect(json["contacts"].length).to be(1)
        expect(json["contacts"].first["name"]).to eq("Billy")
      end
    end

    describe "POST #create" do
      it "creates a new contact in user's organization with a remote id" do
        post :create, contact: {
          name: "Charles Proxly",
          role: "volunteer",
          city: "Auburn, AL",
          bio: "He's got the headers",
          phone: "123-123-1234",
          birthday: "2015-04-04T18:00:57.143Z",
          user_id: user.id,
          added_at: "2015-04-04T18:00:57.143Z",
        }

        new_contact = Contact.last
        expect(new_contact.name).to eq("Charles Proxly")
        expect(new_contact.role).to eq("volunteer")
        expect(new_contact.city).to eq("Auburn, AL")
        expect(new_contact.bio).to eq("He's got the headers")
        expect(new_contact.phone).to eq("123-123-1234")
        expect(new_contact.birthday).to be_a(ActiveSupport::TimeWithZone)
        expect(new_contact.added_at).to be_a(ActiveSupport::TimeWithZone)
        expect(new_contact.remote_id).to match(/[a-zA-Z0-9]{8}/)
        expect(new_contact.organization_id).to eq(organization.id)
        expect(new_contact.user.id).to eq(user.id)
      end
    end
=begin
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
=end
  end
end