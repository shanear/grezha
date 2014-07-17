class UsersController < ApplicationController
  layout "setup"

  def index
    @users = User.where(:organization_id => current_user.organization_id)
  end

  def new
    @user = flash[:user] == nil ? User.new : User.new(JSON.parse(flash[:user]))
    @roles = [["Admin","Admin"],[ "User","User"]]
  end

  def create
    new_user = User.new(user_params)
    if new_user.valid? && new_user.save
      redirect_to users_path
    else
      new_user.password = ""
      redirect_to new_user_path, :flash => {:errors => new_user.errors.messages, :user => new_user.to_json}
    end
  end

  private

  def user_params
    user = params.required(:user).permit(:name, :password, :email, :role)
    user[:organization_id] = current_user.organization_id
    user
  end
end
