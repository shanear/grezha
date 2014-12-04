class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: { status: :alive }
  end

  private

  def current_user
    @current_user ||= User.where(
      authentication_token: @authentication_token
    ).first
  end

  def authenticate_request
    authenticate_or_request_with_http_token do |token, options|
      @authentication_token = token
      current_user
    end
  end
end