class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :organization_id, null: false
      t.string :remote_id, limit: 8, null: false
      t.string :name
      t.datetime :starts_at
      t.string :location
      t.text :notes

      t.timestamps
    end
  end
end
