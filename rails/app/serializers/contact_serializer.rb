class ContactSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :name, :birthday, :phone, :bio, :city, :picture_url, :member_id, :user_id, :added_at

  def id
    object.remote_id
  end

  embed :id
  has_many :connections, embed_key: :remote_id
  has_many :relationships, embed_key: :remote_id

  def picture_url
    _helpers = ActionController::Base.helpers
    object.picture.exists? ? object.picture.url(:medium) : _helpers.image_path("default-contact.png")
  end
end
