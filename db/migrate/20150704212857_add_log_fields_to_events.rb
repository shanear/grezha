class AddLogFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :logged_at, :datetime
    add_column :events, :log_notes, :text
    add_column :events, :other_attendee_count, :integer
  end
end
