class AddRemoteIdToModels < ActiveRecord::Migration
  def change
    add_column :contacts, :remote_id, :string, first: true
    add_column :connections, :remote_id, :string, first: true
    add_column :vehicles, :remote_id, :string, first: true

    [Contact, Connection, Vehicle].each do |model|
      model.all.each do |record|
        record.remote_id = SecureRandom.base64(4).tr('+/=', '012')
        record.save!
      end
    end

    change_column :contacts, :remote_id, :string, limit: 8, null: false
    change_column :connections, :remote_id, :string, limit: 8, null: false
    change_column :vehicles, :remote_id, :string, limit: 8, null: false

    add_index :contacts, :remote_id, :unique => true
    add_index :connections, :remote_id, :unique => true
    add_index :vehicles, :remote_id, :unique => true
  end
end
