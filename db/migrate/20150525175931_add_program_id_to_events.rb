class AddProgramIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :program_id, :integer
  end
end
