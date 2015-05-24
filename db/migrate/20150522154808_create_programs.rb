class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.integer :organization_id, null: false
      t.string :remote_id, limit: 8, null: false
      t.string :name

      t.timestamps
    end
  end
end
