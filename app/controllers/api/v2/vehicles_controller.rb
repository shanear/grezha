class Api::V2::VehiclesController < Api::BaseController
  before_filter :authenticate_request
  respond_to :json

  def create
    @vehicle = vehicles.new(create_vehicle_params)

    if @vehicle.save()
      render json: @vehicle
    else
      render json: { errors: @vehicle.errors }, status: 422
    end
  end

  def update
    @vehicle = find_vehicle(params[:id])

    if @vehicle.update_attributes(create_vehicle_params.except(:remote_id))
      render json: @vehicle
    else
      render json: { errors: @vehicle.errors }, status: 422
    end
  end

  def index
    respond_with vehicles
  end

  def show
    respond_with find_vehicle(params[:id])
  end

  def destroy
    @vehicle = find_vehicle(params[:id])
    @vehicle.destroy

    render json: {}
  end

  private

  def vehicles
    Vehicle.where(organization_id: current_user.organization_id)
  end

  def find_vehicle(id)
    if remote_id?(id)
      vehicles.where(remote_id: id).first!
    else
      vehicles.find(id)
    end
  end

  def create_vehicle_params
    params[:vehicle][:remote_id] = params[:vehicle][:id]
    params.required(:vehicle).permit(:remote_id, :license_plate, :used_by, :notes)
  end
end