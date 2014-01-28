class ContactSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper
  attributes :id, :name, :birthday, :bio, :city, :last_seen, :picture_url

  def picture_url
    object.picture.exists? ? object.picture.url(:medium) : "/assets/no_picture_medium.png"
  end
end