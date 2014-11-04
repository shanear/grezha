class Api::V1::UsersController < ApplicationController
	before_filter :require_logged_in
	respond_to :json
	def index
		respond_with User.where(:organization_id => current_user[:organization_id])
  end

  def show
    respond_with find_user(params[:id])
  end

  private

  def find_user(id)
    User.where(:id => id).first!
  end
end
