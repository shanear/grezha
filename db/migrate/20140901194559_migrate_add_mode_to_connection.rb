class MigrateAddModeToConnection < ActiveRecord::Migration
  def change
    add_column :connections, :mode, :string
  end
end
