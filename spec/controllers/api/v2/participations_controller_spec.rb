require 'spec_helper'

describe Api::V2::ParticipationsController do
  let(:organization) { Organization.create!(name: "Lil Org") }
  let(:user) { FactoryGirl.create(:user, name: "Shophie", organization_id: organization.id) }

  describe "while logged in" do
    before { authorize_api(user) }

    let(:event) {
      FactoryGirl.create(:event,
        name: "My Birthday",
        organization_id: organization.id
      )
    }

    let(:other_event) {
      FactoryGirl.create(:event,
        name: "Regins's Birthday",
        organization_id: organization.id + 1
      )
    }

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

    let(:participation) {
      FactoryGirl.create(:participation, {
        contact: client,
        event: event,
        organization_id: client.organization_id
      })
    }

    describe "POST #create" do
      it "creates a new participation for contact to event" do
        post :create, participation: {
          id: "ABC123",
          event_id: event.remote_id,
          contact_id: client.remote_id
        }


        client.participations.reload
        expect(client.participations[0].remote_id).to eq("ABC123")
        expect(client.participations[0].event).to eq(event)

        event.participations.reload
        expect(event.participations[0].contact).to eq(client)
      end

      it "fails if event is not part of organization" do
        post :create, participation: {
          event_id: other_event.remote_id,
          contact_id: client.remote_id
        }

        expect(response.status).to_not eq(200)
      end

      it "fails if contact is not part of organization" do
        post :create, participation: {
          event_id: event.remote_id,
          contact_id: other_client.remote_id
        }

        expect(response.status).to_not eq(200)
      end
    end

    describe "GET #index" do
      before { participation }

      it "returns program data" do
        get :index, id: participation.id, format: :json
        expect(json["participations"][0]["event_id"]).to eq(event.remote_id)
        expect(json["participations"][0]["contact_id"]).to eq(client.remote_id)
      end
    end
  end
end