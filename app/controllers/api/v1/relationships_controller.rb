class Api::V1::RelationshipsController < ApplicationController
  before_filter :require_logged_in
  respond_to :json

  def create
  	@relationship = relationships.create(create_relationship_params)
    if @relationship.save()
      render json: @relationship
    else
      render json: { errors: @relationship.errors }, status: 422
    end
  end

  def update
    @relationship = find_relationship(params[:id])

    if @relationship.update_attributes(create_relationship_params.except(:remote_id))
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

  private

  def find_relationship(id)
      if remote_id?(id)
      relationships.where(remote_id: id).first!
    else
      relationships.find(id)
    end
  end

  def relationships
    Relationship.where(organization_id: current_user.organization_id)
  end

  def edit_relationship_param
        params.required(:relationship).permit(:remote_id, :contact_id, :notes, :name, :contact_info, :relationship_type, :organization_id)

  end

  def create_relationship_params
    params[:relationship][:remote_id] = params[:relationship][:id]

    if remote_id?(params[:relationship][:contact_id])
      contact = Contact.where(remote_id: params[:relationship][:contact_id]).first
      params[:relationship][:contact_id] = contact.id
    end

  	params.required(:relationship).permit(:remote_id, :contact_id, :notes, :name, :contact_info, :relationship_type, :organization_id)
  end

end