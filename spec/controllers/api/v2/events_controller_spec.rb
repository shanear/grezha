require 'spec_helper'

describe Api::V2::EventsController do
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

      it "uses program remote id to connect" do
        program = FactoryGirl.create("program", {organization_id: organization.id})

        post :create, event: {
          name: "Ice Cream for Dinner",
          program_id: program.remote_id
        }

        expect(Event.last.program).to eq(program)
      end
    end

    describe "PUT #edit" do
      it "updates event" do
        put :update, id: event.id, event: { name: "My Birthday Bash" }, format: :json
        expect(response.status).to eq(200)

        event.reload
        expect(event.name).to eq("My Birthday Bash")
      end

      it "fails if contact not in organization" do
        put :update, id: other_event.id, event: { name: "Regins's Birhtday (updated: more fun)" }, format: :json
        expect(response.status).to_not eq(200)

        other_event.reload
        expect(other_event.name).to eq("Regins's Birthday")
      end
    end

    describe "GET #show" do
      it "returns event" do
        get :show, id: event.id, format: :json
        expect(json["event"]["name"]).to eq("My Birthday")
      end

      it "fails if event not in organization" do
        get :show, id: other_event.id, format: :json
        expect(response.status).to_not eq(200)
      end
    end
  end
end