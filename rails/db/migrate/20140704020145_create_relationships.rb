class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :remote_id
      t.string :name
      t.string :contact_id
      t.string :contact_info
      t.string :relationship_type
      t.string :organization_id
      t.string :notes
      t.string :remote_id, limit: 8, null: false
      t.timestamps
    end
    add_index :relationships, :remote_id, :unique => true
  end
end
