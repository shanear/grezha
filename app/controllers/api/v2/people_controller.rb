class Api::V2::PeopleController < Api::BaseController
  before_filter :authenticate_request
  respond_to :json

  def index
    respond_with people.order('LOWER(name) asc')
  end

  def show
    respond_with find_person(params[:id])
  end

  def create
    person = people.new(person_params)

    if person.save()
      render json: person
    else
      render json: { errors: person.errors }, status: 422
    end
  end

  def update
    person = find_person(params[:id])

    if person.update_attributes(person_update_params)
      render json: person
    else
      render json: { errors: person.errors }, status: 422
    end
  end

  private

  def people
    Person.where(organization_id: current_user.organization_id)
  end

  def find_person(id)
    if remote_id?(id)
      people.where(remote_id: id).first!
    else
      people.find(id)
    end
  end

  def person_update_params
    person_params.except(:remote_id)
  end

  def person_params
    params[:person][:remote_id] = params[:person][:id]
    params.required(:person).permit(:remote_id, :name, :role, :contact_info, :notes)
  end
end