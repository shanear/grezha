class UsersController < ApplicationController

  def index
    @users = User.where(:organization_id => current_user.organization_id)
  end

  def new
    @user = User.new
  end

  def create
    User.create!(user_params)
    redirect_to users_path
  end

  private

  def user_params
    user = params.required(:user).permit(:name, :password, :email)
    user[:organization_id] = current_user.organization_id
    user
  end
end
