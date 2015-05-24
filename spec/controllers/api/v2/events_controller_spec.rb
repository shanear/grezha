require 'spec_helper'

describe Api::V2::EventsController do
  let(:organization) { Organization.create!(name: "Lil Org") }
  let(:user) { FactoryGirl.create(:user, name: "Shophie", organization_id: organization.id) }

  describe "while logged in" do
    before { authorize_api(user) }

    describe "POST #create" do
      it "creates a new event in user's organization with a remote id" do
        post :create, event: {
          name: "Ice Cream for Dinner",
          starts_at: "2015-07-04T18:20:00.000Z",
          location: "Dairy Queen",
          notes: "probably not a good idea. sugar is bad."
        }

        new_event = Event.last
        expect(new_event.remote_id).to match(/[a-zA-Z0-9]{8}/)
        expect(new_event.organization_id).to eq(organization.id)
        expect(new_event.name).to eq("Ice Cream for Dinner")
        expect(new_event.location).to eq("Dairy Queen")
        expect(new_event.starts_at).to eq(DateTime.new(2015, 7, 4, 18, 20))
        expect(new_event.notes).to eq("probably not a good idea. sugar is bad.")
      end
    end
  end
end