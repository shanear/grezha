class AddIntegerIdsToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :organization_id, :integer
    add_column :relationships, :contact_id, :integer
  end
end
