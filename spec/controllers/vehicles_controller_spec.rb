require 'spec_helper'

describe Api::V1::VehiclesController do
  let(:organization) { Organization.create!(name: "Kool Klub") }
  let(:user) { FactoryGirl.create(:user, organization_id: organization.id) }

  describe "while logged in" do
    before { auth_with_user(user) }

    let(:vehicle) {
      FactoryGirl.create(:vehicle, license_plate: "ABC123", organization_id: organization.id)
    }

    let(:other_vehicle) {
      FactoryGirl.create(:vehicle, license_plate: "XYZ789", organization_id: 3)
    }

    describe "GET #index" do
      before { [vehicle, other_vehicle] }

      it "gets vehicles for the user's organization" do
        get :index, format: :json

        expect(json["vehicles"].length).to be(1)
        expect(json["vehicles"].first["license_plate"]).to eq("ABC123")
      end
    end

    describe "GET #show" do
      it "returns vehicle data" do
        get :show, id: vehicle.id, format: :json
        expect(json["vehicle"]["license_plate"]).to eq("ABC123")
      end

      it "fails if vehicle not in organization" do
        expect {
          get :show, id: other_vehicle.id, format: :json
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "POST #create" do
      it "creates a new vehicle in user's organization with a remote id" do
        post :create, vehicle: { license_plate: "SAR123" }

        new_vehicle = Vehicle.last
        expect(new_vehicle.license_plate).to eq("SAR123")
        expect(new_vehicle.remote_id).to match(/[a-zA-Z0-9]{8}/)
        expect(new_vehicle.organization_id).to eq(organization.id)
      end
    end

    describe "PUT #update" do
      it "updates vehicle" do
        put :update, id: vehicle.id, vehicle: { license_plate: "BCD234" }, format: :json

        updated_vehicle = Vehicle.find(vehicle.id)
        expect(updated_vehicle.license_plate).to eq("BCD234")
      end

      it "fails if vehicle not in organization" do
        expect {
          put :update, id: other_vehicle.id, vehicle: {}, format: :json
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "DELETE #destroy" do
      it "deletes vehicle" do
        delete :destroy, id: vehicle.id, format: :json

        expect(Vehicle.exists?(vehicle.id)).to be_false
      end

      it "fails if vehicle not in organization" do
        expect {
          delete :destroy, id: other_vehicle.id, format: :json
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end