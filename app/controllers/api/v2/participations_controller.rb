class Api::V2::ParticipationsController < Api::BaseController
  before_filter :authenticate_request
  respond_to :json

  def index
    respond_with participations
  end

  def create
    @participation = participations.create(create_participation_params)

    if @participation.save()
      render json: @participation
    else
      render json: { errors: @participation.errors }, status: 422
    end
  end

  def destroy
    @participation = find_participation(params[:id])
    @participation.destroy

    respond_with json: {}
  end

  private

  def participations
    Participation.where(organization_id: current_user.organization_id)
  end

  def find_participation(id)
    if remote_id?(id)
      participations.where(remote_id: id).first!
    else
      participations.find(id)
    end
  end

  def create_participation_params
    params[:participation][:remote_id] = params[:participation][:id]

    if remote_id?(params[:participation][:contact_id])
      contact = Contact.where(remote_id: params[:participation][:contact_id]).first
      params[:participation][:contact_id] = contact.id
    end

    if remote_id?(params[:participation][:event_id])
      event = Event.where(remote_id: params[:participation][:event_id]).first
      params[:participation][:event_id] = event.id
    end

    params.required(:participation).permit(:remote_id, :contact_id, :event_id, :registered_at)
  end
end