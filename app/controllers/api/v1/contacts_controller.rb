class Api::V1::ContactsController < ApplicationController
  before_filter :require_logged_in

  respond_to :json

  def index
    respond_with Contact.order('LOWER(name) asc')
  end

  def show
    respond_with Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update_attributes(create_contact_params)

    render json: @contact
  end

  def create
  	@contact = Contact.create(create_contact_params)
  	@contact.save()
    render json: @contact
  end

  def upload_image
    @contact = Contact.find(params[:id])
    @contact.update_attributes(picture: params[:image])

    render json: { imageUrl: @contact.picture.url(:medium) }
  end

  private

  def create_contact_params
  	params.required(:contact).permit(:name, :city, :bio, :birthday)
  end
end