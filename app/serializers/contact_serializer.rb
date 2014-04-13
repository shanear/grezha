class ContactSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :name, :birthday, :bio, :city, :picture_url

  embed :ids, include: true
  has_many :connections

  def picture_url
    _helpers = ActionController::Base.helpers
    object.picture.exists? ? object.picture.url(:medium) : _helpers.image_path("default-contact.png")
  end
end