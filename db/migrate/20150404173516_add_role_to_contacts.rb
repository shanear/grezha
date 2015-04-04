class AddRoleToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :role, :string

    Contact.all.update_all(role: 'client')
  end
end
