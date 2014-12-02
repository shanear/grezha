class Api::CsrfController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: {
      request_forgery_protection_token => form_authenticity_token
    }.to_json
  end
end