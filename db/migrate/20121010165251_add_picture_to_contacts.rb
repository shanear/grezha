class AddPictureToContacts < ActiveRecord::Migration
  def up
    add_attachment :contacts, :picture
  end

  def down
    remove_attachment :contacts, :picture
  end
end
