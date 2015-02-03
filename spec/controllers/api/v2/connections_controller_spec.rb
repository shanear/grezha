require 'spec_helper'

describe Api::V2::ConnectionsController do
  let(:organization) { Organization.create!(name: "Lil Org") }
  let(:user) { FactoryGirl.create(:user, name: "Shophie", organization_id: organization.id) }
  before { authorize_api(user) }

  let(:contact) { connection.contact }

  let(:connection) {
    FactoryGirl.create(:connection, note: "Cowabunga", mode: "Email", organization_id: organization.id)
  }

  let(:other_connection) {
    FactoryGirl.create(:connection, note: "Cheers", organization_id: organization.id + 1)
  }

  describe "GET #index" do
    before { [connection, other_connection] }

    it "gets connections for the user's organization" do
      get :index, format: :json

      expect(json["connections"].length).to be(1)
      expect(json["connections"].first["note"]).to eq("Cowabunga")
    end
  end

  describe "GET #show" do
    it "returns connection data" do
      get :show, id: connection.id, format: :json
      expect(json["connection"]["note"]).to eq("Cowabunga")
      expect(json["connection"]["mode"]).to eq("Email")
    end

    it "fails if contact not in organization" do
      expect {
        get :show, id: other_connection.id, format: :json
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    it "creates a new connection in user's organization with a remote id" do
      post :create, connection: { note: "Howey", mode: "In Person", contact_id: contact.id}

      new_connection = Connection.last
      expect(new_connection.note).to eq("Howey")
      expect(new_connection.mode).to eq("In Person")
      expect(new_connection.remote_id).to match(/[a-zA-Z0-9]{8}/)
      expect(new_connection.organization_id).to eq(organization.id)
    end
  end

  describe "DELETE #destroy" do
    it "deletes connection" do
      delete :destroy, id: connection.id, format: :json

      expect(Connection.exists?(connection.id)).to be_false
    end

    it "fails if contact not in organization" do
      expect {
        delete :destroy, id: other_connection.id, format: :json
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
