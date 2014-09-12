class Api::V1::ContactsController < ApplicationController
  before_filter :require_logged_in

  respond_to :json

  def index
    test = contacts.order('LOWER(name) asc')
    respond_with test
  end

  def show
    respond_with find_contact(params[:id])
  end

  def update
    @contact = find_contact(params[:id])

    if @contact.update_attributes(create_contact_params.except(:remote_id))
      render json: @contact
    else
      render json: { errors: @contact.errors }, status: 422
    end
  end

  def create
  	@contact = contacts.new(create_contact_params)
    @contact.organization_id = current_user.organization_id
    if @contact.save()
      render json: @contact
    else
      render json: { errors: @contact.errors }, status: 422
    end
  end

  def destroy
    @contact = find_contact(params[:id])
    @contact.destroy

    render json: {}
  end

  def upload_image
    @contact = find_contact(params[:id])
    @contact.update_attributes(picture: params[:image])

    render json: { imageUrl: @contact.picture.url(:medium) }
  end

  private

  def contacts
    Contact.where(organization_id: current_user.organization_id)
  end

  def find_contact(id)
    if remote_id?(id)
      contacts.where(remote_id: id).first!
    else
      contacts.find(id)
    end
  end

  def create_contact_params
    params[:contact][:remote_id] = params[:contact][:id]
  	params.required(:contact).permit(:remote_id, :name, :city, :bio, :birthday, :phone, :cdcr_id)
  end
end