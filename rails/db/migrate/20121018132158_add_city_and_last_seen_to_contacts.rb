class AddCityAndLastSeenToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :city, :string
    add_column :contacts, :last_seen, :date
  end
end
