class ReplaceDateWithOccurredAtOnConnections < ActiveRecord::Migration
  def change
    add_column :connections, :occurred_at, :datetime
    remove_column :connections, :date
  end
end
