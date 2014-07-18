class UsersController < ApplicationController
  layout "setup"

  def index
    @users = User.where(:organization_id => current_user.organization_id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path
    else
      @user.password = ""
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def user_params
    user = params.required(:user).permit(:name, :password, :email, :role)
    user[:organization_id] = current_user.organization_id
    user
  end
end
