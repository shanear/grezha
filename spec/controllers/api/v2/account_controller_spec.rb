require 'spec_helper'

describe Api::V2::AccountController do
  let!(:user) {
    FactoryGirl.create(:user, email: "shake@gmail.com")
  }

  describe "POST /forgot_password" do
    context "when no users with email exist" do
      it "responds 422" do
        post :forgot_password, {
          email: "not-a-user@gmail.com"
        }

        expect(response.status).to eq(422)
      end
    end

    context "user with email exists" do
      it "responds 200 and sends email to user" do
        email = double('mail')
        expect(email).to receive(:deliver)

        expect(UserMailer).to receive(:forgot_password_email)
          .with(user, /\/reset-password\//)
          .and_return(email)

        post :forgot_password, {
          email: "shake@gmail.com"
        }

        expect(response.status).to eq(200)

        user.reload
        expect(user.reset_password_token).to_not be_nil
      end
    end
  end
end