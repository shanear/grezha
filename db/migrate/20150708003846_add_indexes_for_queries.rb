class AddIndexesForQueries < ActiveRecord::Migration
  def change
  	add_index :relationships, [:organization_id]
  	add_index :vehicles, [:organization_id]
  	add_index :connections, [:organization_id]
  	add_index :people, [:organization_id]
  	add_index :events, [:organization_id]
  	add_index :users, [:organization_id]
  end
end
