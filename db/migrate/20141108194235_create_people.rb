class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :organization_id
      t.string :remote_id, limit: 8, null: false

      t.string :name
      t.string :role
      t.string :contact_info
      t.string :notes
      t.timestamps
    end

    add_column :relationships, :person_id, :integer
    add_index :people, :remote_id, :unique => true
  end
end
