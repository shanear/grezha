class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :organization_id
      t.string :remote_id, limit: 8, null: false
      t.belongs_to :contact
      t.belongs_to :event

      t.timestamps
    end
  end
end
