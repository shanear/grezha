class RelationshipStringIdsToIntegers < ActiveRecord::Migration
  def change
    remove_column :relationships, :contact_id
    remove_column :relationships, :organization_id
  end
end
