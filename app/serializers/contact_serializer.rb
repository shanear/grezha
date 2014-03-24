class ContactSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :name, :birthday, :bio, :city, :last_seen, :picture_url

  embed :ids, include: true
  has_many :connections

  def picture_url
    _helpers = ActionController::Base.helpers
    object.picture.exists? ? object.picture.url(:medium) : _helpers.image_path("no_picture_medium.png")
  end
end