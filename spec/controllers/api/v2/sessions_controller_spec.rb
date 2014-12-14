require 'spec_helper'

describe Api::V2::SessionsController do
  let!(:user) { FactoryGirl.create(:user) }

  describe "POST /authenticate" do
    context "when bad credentials" do
      it "responds 401" do
        post :create, {
          email: user.email ,
          password: "incorrect#{user.password}"
        }

        expect(response.status).to eq(401)
      end
    end

    context "when good credentials" do
      it "responds 200 and returns auth token" do
        post :create, {
          email: user.email,
          password: user.password
        }

        user.reload
        expect(response.status).to eq(200)

        session = json["session"]
        expect(session["token"]).to eq(user.authentication_token)
        expect(session["username"]).to eq(user.name)
      end
    end
  end

  describe "POST /invalidate" do
    context "when not authenticated" do
      it "responds 401" do
        post :destroy
        expect(response.status).to eq(401)
      end
    end

    context "when authenticated" do
      it "responds 200" do
        authorize_api(user)

        post :destroy
        expect(response.status).to eq(200)
      end
    end
  end
end