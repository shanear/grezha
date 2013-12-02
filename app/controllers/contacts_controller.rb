class ContactsController < ApplicationController
  before_filter :require_logged_in

  def index
    @contacts = Contact.scoped

    if(@birthday_month = params[:birthday_month])
      @contacts = @contacts.with_birthday_month(@birthday_month)
    else
      @contacts = @contacts.order('LOWER(name) asc')
    end

    @contacts = @contacts.all

    respond_to do |format|
      format.html
      format.json { render json: @contacts }
    end
  end

  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  def new
    @contact = Contact.new
    5.times { @contact.children.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  def edit
    @contact = Contact.find(params[:id])
    5.times { @contact.children.build }
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(contact_params)
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :bio, :birthday, :name, :picture, :city, :last_seen,
      children_attributes: [:name, :age]
    )
  end
end
