require 'spec_helper'

describe Vehicle do
  context "create" do
    context "when no remote_id is provided" do
      it "automatically populates it with a valid id" do
        vehicle = Vehicle.create(license_plate: "34132")
        expect(vehicle.remote_id).to match(/[A-Za-z0-9]{8}/)
      end
    end
  end

  it "should validate uniqueness of license plate" do
    @vehicle = FactoryGirl.create(:vehicle)
    @duplicate_vehicle = FactoryGirl.build(:vehicle)

    @duplicate_vehicle.license_plate = @vehicle.license_plate
    @duplicate_vehicle.should_not be_valid
  end
end
