require 'spec_helper'

describe Relationship do
	let(:relationship) { FactoryGirl.build(:relationship) }
  context "builds remote id" do
  	 it "automatically populates it with a valid id" do
        relationship = FactoryGirl.build(:relationship, remote_id: nil)
        relationship.save!
        expect(relationship.remote_id).to match(/[A-Za-z0-9]{8}/)
      end
  end

  context "validity of relationships" do
  	it "is invalid when contact organization doesn't match" do
  		relationship = FactoryGirl.build(:relationship)
  		relationship.organization_id += 1
  		expect(relationship).to_not be_valid
  	end

  	it "is invalid when no contact" do
  		relationship = FactoryGirl.build(:relationship)
  		relationship.contact = nil
  		expect(relationship).to_not be_valid
  	end

  	it "is invalid when no relationship type" do
  		relationship = FactoryGirl.build(:relationship)
  		relationship.relationship_type = nil
  		expect(relationship).to_not be_valid
  	end

  end



end
