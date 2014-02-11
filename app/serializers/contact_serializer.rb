class ContactSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper
  attributes :id, :name, :birthday, :bio, :city, :last_seen, :picture_url

  def attributes
    hash = super
    # Adding 12 hours to date is a hacky way to avoid parsing wrong date because of timezones
    hash['birthday'] = (object.birthday.to_datetime + 12.hours).iso8601 if object.birthday
    hash
  end

  def picture_url
    object.picture.exists? ? object.picture.url(:medium) : "/assets/no_picture_medium.png"
  end
end