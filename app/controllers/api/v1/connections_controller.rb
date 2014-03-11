class Api::V1::ConnectionsController < ApplicationController
  before_filter :require_logged_in
  respond_to :json

  def create
  	@connection = Connection.create(create_connection_params)
  	@connection.save()
    render json: @connection
  end

  private

  def create_connection_params
  	params.required(:connection).permit(:contact_id, :note, :date)
  end
end