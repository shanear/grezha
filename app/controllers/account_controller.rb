class AccountController < ApplicationController
  before_filter :require_logged_out, only: :forgot_password

  def forgot_password
    if request.post?
      user = User.where(email: params[:user][:email]).first

      if user
        user.generate_password_reset
        user.save!

        UserMailer.forgot_password_email(user,
          reset_password_url(user)).deliver

        flash[:notice] = "We sent a password reset link to your email address. You should see it here soon."

        redirect_to login_path
      else
        flash.now[:alert] = "There is no user with that username..."
      end
    end
  end

  def reset_password
    @user = User.where(reset_password_token: params[:token]).first || current_user

    redirect_to root_path unless @user

    if request.patch?
      if @user.update(reset_password_params)
        redirect_to root_path
        flash[:notice] = "Password changed. Make sure not to forget it!"
      else
        flash.now[:alert] = current_user.errors.full_messages.first
      end
    end
  end

  private

  def reset_password_params
    params[:user][:password] ||= ""
    params.require(:user).permit(:password, :password_confirmation)
  end

  def reset_password_url(user)
    "#{request.host}/reset-password/#{user.reset_password_token}"
  end
end