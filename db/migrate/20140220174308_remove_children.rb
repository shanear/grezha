class RemoveChildren < ActiveRecord::Migration
  def change
    drop_table :children
  end
end
