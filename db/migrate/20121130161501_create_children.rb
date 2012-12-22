class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.belongs_to :contact
      t.string :name
      t.datetime :birth_date

      t.timestamps
    end
  end
end
