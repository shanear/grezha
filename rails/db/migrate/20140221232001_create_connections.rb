class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.text :note
      t.date :date
      t.belongs_to :contact

      t.timestamps
    end
  end
end
