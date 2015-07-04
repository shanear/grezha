class AddConfirmedAtToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :confirmed_at, :datetime
  end
end
