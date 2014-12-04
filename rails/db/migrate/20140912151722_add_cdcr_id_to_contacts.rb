class AddCdcrIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :cdcr_id, :string
  end
end
