class AddAddedAtToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :added_at, :datetime
  end
end
