class Api::V2::RegistrationsController < Api::BaseController
  before_filter :authenticate_request
  respond_to :json

  def index
    respond_with registrations
  end

  def create
    @registration = registrations.create(create_registration_params)

    if @registration.save()
      render json: @registration
    else
      render json: { errors: @registration.errors }, status: 422
    end
  end

  private

  def registrations
    Registration.where(organization_id: current_user.organization_id)
  end

  def find_registration(id)
    if remote_id?(id)
      registrations.where(remote_id: id).first!
    else
      registrations.find(id)
    end
  end

  def create_registration_params
    params[:registration][:remote_id] = params[:registration][:id]

    if remote_id?(params[:registration][:contact_id])
      contact = Contact.where(remote_id: params[:registration][:contact_id]).first
      params[:registration][:contact_id] = contact.id
    end

    if remote_id?(params[:registration][:event_id])
      event = Event.where(remote_id: params[:registration][:event_id]).first
      params[:registration][:event_id] = event.id
    end

    params.required(:registration).permit(:remote_id, :contact_id, :event_id)
  end
end