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
    params[:connection][:remote_id] = params[:connection][:id]

    contact = Contact.where(remote_id: params[:connection][:contact_id]).first
    params[:connection][:contact_id] = contact.id

  	params.required(:connection).permit(:remote_id, :contact_id, :note, :occurred_at)
  end
end