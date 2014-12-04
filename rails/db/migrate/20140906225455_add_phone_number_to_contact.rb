class AddPhoneNumberToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :phone, :string
  end

end
