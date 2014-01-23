class Api::V1::ContactsController < ApplicationController

  respond_to :json

  def index
    respond_with Contact.order('LOWER(name) asc').all
  end

  def show
    respond_with Contact.find(params[:id])
  end

  def create
  	contact = Contact.create(create_contact_params)
  	contact.save()
  end

  private

  def create_contact_params
  	params.required(:contact).permit(:name, :city, :bio, :last_seen, :birthday)
  end

end