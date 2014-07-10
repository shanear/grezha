class Api::V1::RelationshipsController < ApplicationController
  before_filter :require_logged_in
  respond_to :json

  def create
  	@relationship = relationships.create(create_connection_params)
    if @relationship.save()
      render json: @relationship
    else
      render json: { errors: @relationship.errors }, status: 422
    end
  end


  def show
    respond_with find_relationship(params[:id])
  end

  def index
    respond_with relationships
  end

  def destroy
    @relationship = find_relationship(params[:id])
    @relationship.destroy

    respond_with json: {}
  end

  def find_relationship(id)
  	  if remote_id?(id)
      relationships.where(remote_id: id).first!
    else
      relationships.find(id)
    end
  end


  private

  def relationships
    Relationship.where(organization_id: current_user.organization_id)
  end

  def create_connection_params
    params[:relationship][:remote_id] = params[:relationship][:id]

    if remote_id?(params[:relationship][:contact_id])
      contact = Contact.where(remote_id: params[:relationship][:contact_id]).first
      params[:relationship][:contact_id] = contact.id
    end

  	params.required(:relationship).permit(:remote_id, :contact_id, :notes, :name, :contact_info, :relationship_type, :organization_id)
  end

end