class Api::V2::SessionsController < Api::BaseController
  before_filter :authenticate_request, :only => [:destroy]

  def create
    user = User.api_authenticate(
      params[:email], params[:password]
    )

    if user
      render json: { token: user.authentication_token }
    else
      render json: { message: "Username and password incorrect" },
          status: 401
    end
  end

  def destroy
    render json: { success: true }
  end
end
