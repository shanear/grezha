class SessionsController < ApplicationController
  before_filter :require_logged_in, :only => [:destroy]
  before_filter :require_logged_out, :only => [:new, :create]

  def new
  end

  def create
    if user = User.authenticate(params[:session][:email], params[:session][:password])
      login user

      redirect_to root_path
    else
      flash[:alert] = "Incorrect username or password. Please contact your administrator if cannot login."
      render 'new'
    end
  end

  def destroy
    logout

    flash[:notice] = "Logged out!"
    redirect_to login_path
  end
end
