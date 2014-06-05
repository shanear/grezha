class Api::V1::ConnectionsController < ApplicationController
  before_filter :require_logged_in
  respond_to :json

  def create
  	@connection = Connection.create(create_connection_params)

    if @connection.save()
      render json: @connection
    else
      render json: { errors: @connection.errors }, status: 422
    end
  end

  def show
    respond_with find_connection(params[:id])
  end

  def index
    respond_with Connection.all
  end

  def destroy
    @connection = find_connection(params[:id])
    @connection.destroy

    respond_with json: {}
  end

  private

  def find_connection(id)
    if remote_id?(id)
      Connection.where(remote_id: id).first!
    else
      Connection.find(id)
    end
  end

  def create_connection_params
    params[:connection][:remote_id] = params[:connection][:id]

    contact = Contact.where(remote_id: params[:connection][:contact_id]).first
    params[:connection][:contact_id] = contact.id

  	params.required(:connection).permit(:remote_id, :contact_id, :note, :occurred_at)
  end
end