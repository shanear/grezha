class AccountController < ApplicationController
  before_filter :require_logged_in

  def reset_password
    if request.patch?
      if current_user.update(reset_password_params)
        redirect_to root_path
        flash[:notice] = "Password changed. Make sure not to forget it!"
      else
        flash.now[:alert] = current_user.errors.full_messages.first
      end
    end
  end

  private

  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end