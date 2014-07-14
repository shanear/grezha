class UsersController < ApplicationController

  def index
    @users = User.where(:organization_id => current_user.organization_id)
  end

  def new
    @user = User.new
  end

  def create
    new_user = User.new(user_params)
    if new_user.valid? && new_user.save
      redirect_to users_path
    else
      @errors = new_user.errors
      redirect_to new_user_path
    end
  end

  private

  def user_params
    user = params.required(:user).permit(:name, :password, :email)
    user[:organization_id] = current_user.organization_id
    user
  end
end
