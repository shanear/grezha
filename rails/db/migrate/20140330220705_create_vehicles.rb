class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.text :notes
      t.string :used_by

      t.timestamps
    end
  end
end
