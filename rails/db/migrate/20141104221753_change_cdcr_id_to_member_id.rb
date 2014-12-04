class ChangeCdcrIdToMemberId < ActiveRecord::Migration
  def change
    rename_column :contacts, :cdcr_id, :member_id
  end
end
