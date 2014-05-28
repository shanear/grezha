class ContactSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :name, :birthday, :bio, :city, :picture_url

  def id
    object.remote_id
  end

  embed :id
  has_many :connections, embed_key: :remote_id

  def picture_url
    _helpers = ActionController::Base.helpers
    object.picture.exists? ? object.picture.url(:medium) : _helpers.image_path("default-contact.png")
  end
end