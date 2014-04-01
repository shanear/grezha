require 'spec_helper'

describe Vehicle do
  it "should validate uniqueness of license plate" do
    @vehicle = FactoryGirl.create(:vehicle)
    @duplicate_vehicle = FactoryGirl.build(:vehicle,
      license_plate: @vehicle.license_plate)

    @duplicate_vehicle.should_not be_valid
  end
end
