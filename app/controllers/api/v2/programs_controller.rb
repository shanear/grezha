class Api::V2::ProgramsController < Api::BaseController
  before_filter :authenticate_request
  respond_to :json

  def index
    respond_with programs
  end

  def create
    @program = programs.new(create_program_params)
    @program.organization_id = current_user.organization_id

    if @program.save()
      render json: @program
    else
      render json: { errors: @program.errors }, status: 422
    end
  end

  private

  def programs
    Program.where(organization_id: current_user.organization_id)
  end

  def create_program_params
    params[:program][:remote_id] = params[:program][:id]
    params.required(:program).permit(:remote_id, :name)
  end
end
