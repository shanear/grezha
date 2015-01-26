require 'spec_helper'

describe Api::V2::UsersController do
  let(:organization) { Organization.create!(name: "Lil Org") }
  let(:user) { FactoryGirl.create(:user, name: "Shophie", organization_id: organization.id) }
  before { authorize_api(user) }

  describe "GET /" do
    it "gets users for the user's organization" do
      get :index, format: :json

      expect(json["users"].length).to be(1)
      expect(json["users"].first["name"]).to eq("Shophie")
    end
  end

  describe "GET /:id" do
    it "returns user data" do
      get :show, id: user.id, format: :json
      expect(json["user"]["name"]).to eq("Shophie")
    end
  end
end

