class Api::V1::VehiclesController < ApplicationController
  before_filter :require_logged_in

  respond_to :json

  def index
    respond_with Vehicle.all
  end

  def show
    respond_with Vehicle.find(params[:id])
  end
end