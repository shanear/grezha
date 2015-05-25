class Api::V2::EventsController < Api::BaseController
  before_filter :authenticate_request
  respond_to :json

  def create
    @event = events.new(create_event_params)
    @event.organization_id = current_user.organization_id

    if @event.save()
      render json: @event
    else
      render json: { errors: @event.errors }, status: 422
    end
  end

  def index
    respond_with events
  end

  private

  def events
    Event.where(organization_id: current_user.organization_id)
  end

  def create_event_params
    params[:event][:remote_id] = params[:event][:id]

    if remote_id?(params[:event][:program_id])
      program = Program.where(remote_id: params[:event][:program_id]).first
      params[:event][:program_id] = program.id
    end

    params.required(:event).permit(:remote_id, :program_id, :name, :starts_at, :location, :notes)
  end
end
