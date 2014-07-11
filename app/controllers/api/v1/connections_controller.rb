class Api::V1::ConnectionsController < ApplicationController
  before_filter :require_logged_in
  respond_to :json

  def create
  	@connection = connections.create(create_connection_params)

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
    respond_with connections
  end

  def destroy
    @connection = find_connection(params[:id])
    @connection.destroy

    respond_with json: {}
  end

  private

  def connections
    Connection.where(organization_id: current_user.organization_id)
  end

  def find_connection(id)
    if remote_id?(id)
      connections.where(remote_id: id).first!
    else
      connections.find(id)
    end
  end

  def create_connection_params
    params[:connection][:remote_id] = params[:connection][:id]

    if remote_id?(params[:connection][:contact_id])
      contact = Contact.where(remote_id: params[:connection][:contact_id]).first
      params[:connection][:contact_id] = contact.id
    end
  	params.required(:connection).permit(:remote_id, :contact_id, :note, :occurred_at)
  end
end
