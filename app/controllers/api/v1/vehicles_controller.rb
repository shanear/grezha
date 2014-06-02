class Api::V1::VehiclesController < ApplicationController
  before_filter :require_logged_in

  respond_to :json

  def create
    @vehicle = Vehicle.create(create_vehicle_params)
    @vehicle.save()
    render json: @vehicle
  end

  def update
    @vehicle = find_vehicle(params[:id])
    @vehicle.update_attributes(create_vehicle_params.except(:remote_id))
    render json: @vehicle
  end

  def index
    respond_with Vehicle.all
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

  def find_vehicle(id)
    if remote_id?(id)
      Vehicle.where(remote_id: id).first!
    else
      Vehicle.find(id)
    end
  end

  def create_vehicle_params
    params[:vehicle][:remote_id] = params[:vehicle][:id]
    params.required(:vehicle).permit(:remote_id, :license_plate, :used_by, :notes)
  end
end