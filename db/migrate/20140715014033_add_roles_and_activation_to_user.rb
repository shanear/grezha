class AddRolesAndActivationToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, :default => "Admin"
    add_column :users, :active, :boolean, :default => true
  end
end
