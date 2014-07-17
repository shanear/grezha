class AddRolesAndActivationToUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :active, :boolean
  end
end
