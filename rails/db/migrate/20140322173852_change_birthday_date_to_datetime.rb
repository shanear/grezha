class ChangeBirthdayDateToDatetime < ActiveRecord::Migration
  def up
    change_column :contacts, :birthday, :datetime
  end

  def down
    change_column :contacts, :birthday, :date
  end
end
