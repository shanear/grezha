class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :get_authentication

  def index
    render json: { status: :alive }
  end

  private

  def current_user
    @current_user
  end

  def get_authentication
    authenticate_with_http_token do |token, options|
      @current_user = User.where(
        authentication_token: token
      ).first
    end
  end

  def authenticate_request
    request_http_token_authentication unless current_user
  end
end