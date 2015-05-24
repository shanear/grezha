class Api::V2::ProgramsController < Api::BaseController
  before_filter :authenticate_request
  respond_to :json

  def index
    respond_with programs
  end

  private

  def programs
    Program.where(organization_id: current_user.organization_id)
  end
end
