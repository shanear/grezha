class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :birthday, :bio, :city, :last_seen
end