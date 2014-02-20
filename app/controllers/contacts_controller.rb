class ContactsController < ApplicationController
  before_filter :require_logged_in

  def birthdays
    @recent = Contact.with_recent_birthday
    @upcoming = Contact.with_upcoming_birthday
  end
end
