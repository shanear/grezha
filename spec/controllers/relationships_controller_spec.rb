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
    	FactoryGirl.create(:relationship, name: "a different probation officer", organization_id: organization.id + 1)
    }

	end
end