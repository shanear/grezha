class UsersController < ApplicationController
  layout "setup"
  before_filter :require_logged_in
  before_filter :require_admin

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
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_edit_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  private

  def user_params
    puts current_user
    user = params.required(:user).permit(:name, :password, :email, :role)
    user[:organization_id] = current_user.organization_id
    user
  end

  def user_edit_params
    params.require(:user).permit(:name, :email, :role)
  end
end
