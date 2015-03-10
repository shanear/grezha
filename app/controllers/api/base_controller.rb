class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :get_authentication
  before_filter :set_cors_origin

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

  def set_cors_origin
    allowed_origin_patterns = [
      /\Ahttps?:\/\/localhost:4200\z/,
      /\Ahttps?:\/\/staging.grezha.divshot.io\z/,
      /\Ahttps?:\/\/production.grezha.divshot.io\z/,
      /\Ahttps?:\/\/app.grezha.org\z/,
      /\Ahttps?:\/\/www.grezha.org\z/,
      /\Ahttps?:\/\/grezha.org\z/
    ]

    allowed_origin_patterns.each do |pattern|
      if pattern =~ request.headers['Origin']
        headers['Access-Control-Allow-Origin'] =
          request.headers["Origin"]
      end
    end
  end


  rescue_from StandardError, with: :render_unknown_error
  def render_unknown_error(error)
    render(json: error.inspect, status: 500)
  end
end