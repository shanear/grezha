class Api::V2::AccountController < ApplicationController
  def forgot_password
    user = User.where(email: params[:email]).first

    if user
      user.generate_password_reset
      user.save!

      UserMailer.forgot_password_email(user,
        reset_password_url(user)).deliver

      render json: { success: true }
    else
      render status: 422, json: {
        message: "There is no user with that username..."
      }
    end
  end

  private

  def reset_password_url(user, path = "reset-password")
    "#{request.host}/reset-password/#{user.reset_password_token}"
  end
end