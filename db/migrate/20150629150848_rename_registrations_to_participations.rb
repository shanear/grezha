class RenameRegistrationsToParticipations < ActiveRecord::Migration
  def change
    rename_table :registrations, :participations
  end
end
