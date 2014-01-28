class Api::V1::ContactsController < ApplicationController

  respond_to :json

  def index
    respond_with Contact.order('LOWER(name) asc').all
  end

  def show
    respond_with Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(create_contact_params)
    respond_with @contact
  end

  def create
  	@contact = Contact.create(create_contact_params)
  	@contact.save()
    respond_with @contact
  end

  def upload_image
    @contact = Contact.find(params[:id])
    @contact.update_attributes(picture: params[:image])

    render json: { imageUrl: @contact.picture.url(:medium) }
  end

  private

  def create_contact_params
  	params.required(:contact).permit(:name, :city, :bio, :last_seen, :birthday)
  end
end