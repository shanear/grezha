class Api::V1::VehiclesController < ApplicationController
  before_filter :require_logged_in

  respond_to :json

  def create
    @vehicle = Vehicle.create(create_vehicle_params)
    @vehicle.save()
    render json: @vehicle
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    @vehicle.update_attributes(create_vehicle_params)
    render json: @vehicle
  end

  def index
    respond_with Vehicle.all
  end

  def show
    respond_with Vehicle.find(params[:id])
  end

  private

  def create_vehicle_params
    params.required(:vehicle).permit(:license_plate, :used_by, :notes)
  end
end