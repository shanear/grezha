require 'spec_helper'

describe Api::V2::AccountController do
  let!(:user) {
    FactoryGirl.create(:user,
      email: "shake@gmail.com",
      authentication_token: "token"
    )
  }

  describe "POST /forgot-password" do
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
        expect(json['success']).to be_true

        user.reload
        expect(user.reset_password_token).to_not be_nil
      end
    end
  end

  describe "PUT /reset-password" do
    context "when authenticated" do
      before { authorize_api(user) }

      context "when params are valid" do
        it "updates user password and repsonds 200" do
          put :reset_password, {
            password: "passw0rd",
            password_confirmation: "passw0rd"
          }

          expect(response.status).to eq(200)

          matching_user = User.authenticate("shake@gmail.com", "passw0rd")
          expect(matching_user).to eq(user)
        end
      end

      context "when params aren't valid" do
        it "responds 422" do
          put :reset_password, {
            password: "passw0rd",
            password_confirmation: "passw0rd-oops"
          }

          expect(response.status).to eq(422)
          expect(json["errors"]).to_not be_nil
        end
      end
    end

    context "when email matches password reset token" do
      before do
        user.generate_password_reset
        user.save!
      end

      context "when password matches confirmation" do
        it "updates user password and repsonds 200" do
          put :reset_password, {
            email: user.email,
            token: user.reset_password_token,
            password: "passw0rd",
            password_confirmation: "passw0rd"
          }

          expect(response.status).to eq(200)

          matching_user = User.authenticate("shake@gmail.com", "passw0rd")
          expect(matching_user).to eq(user)
        end
      end

      context "when password doesn't match confirmation" do
        it "responds 422" do
          put :reset_password, {
            email: user.email,
            token: user.reset_password_token,
            password: "passw0rd",
            password_confirmation: "passw0rd-oops"
          }

          expect(response.status).to eq(422)
          expect(json["errors"]).to_not be_nil
        end
      end
    end

    context "when email doesn't match password reset token" do
      it "responds 403" do
        user.generate_password_reset
        user.save!

        put :reset_password, {
          email: user.email,
          token: user.reset_password_token + "x",
          password: "passw0rd",
          password_confirmation: "passw0rd"
        }

        expect(response.status).to eq(403)
      end
    end
  end
end