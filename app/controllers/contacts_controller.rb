class ContactsController < ApplicationController
  before_filter :require_logged_in

  def birthdays
    contacts = Contact.where(organization_id: current_user.organization_id)

    @recent = contacts.with_recent_birthday
    @upcoming = contacts.with_upcoming_birthday
  end
end
