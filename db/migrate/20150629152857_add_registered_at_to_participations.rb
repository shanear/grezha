class AddRegisteredAtToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :registered_at, :datetime
  end
end
