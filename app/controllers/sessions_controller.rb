class SessionsController < ApplicationController
  before_filter :require_logged_in, :only => [:destroy]
  before_filter :require_logged_out, :only => [:new]

  def new
  end

  def admin_new
  end

  def create
    if user = User.authenticate(params[:session][:email], params[:session][:password])
      login user

      if(params[:admin])
        redirect_to users_path
      else
        redirect_to root_path
      end
    else
      flash[:alert] = "Incorrect username or password. Please contact your administrator if cannot login."
      render (params[:admin] ? 'admin_new' : 'new')
    end
  end

  def destroy
    logout
    redirect_to login_path
  end

  def admin_destroy
    logout
    redirect_to admin_login_path
  end
end
