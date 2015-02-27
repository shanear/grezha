class Api::V2::AccountController < Api::BaseController
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

  def reset_password
    if reset_password_user
      if reset_password_user.update(reset_password_params)
        render status: 200, json: {}
      else
        render status: 422, json: { errors: reset_password_user.errors }
      end
    else
      render status: 403, json: {}
    end
  end

  private

  def reset_password_user
    @reset_password_user ||= current_user || User.where({
        email: params[:email],
        reset_password_token: params[:token]
      }).first
  end

  def reset_password_params
    params.permit(:password, :password_confirmation)
  end

  def reset_password_url(user)
    "#{app_url}#/reset-password/#{user.reset_password_token}"
  end
end