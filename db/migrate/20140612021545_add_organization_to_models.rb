class AddOrganizationToModels < ActiveRecord::Migration
  def change
    add_column :users, :organization_id, :integer
    add_column :contacts, :organization_id, :integer
    add_column :connections, :organization_id, :integer
    add_column :vehicles, :organization_id, :integer
  end
end
