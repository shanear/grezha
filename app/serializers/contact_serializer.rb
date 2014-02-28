class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :birthday, :bio, :city, :last_seen, :picture_url

  embed :ids, include: true
  has_many :connections

  def attributes
    hash = super
    # Adding 12 hours to date is a hacky way to avoid parsing wrong date because of timezones
    hash['birthday'] = (object.birthday.to_datetime + 12.hours).iso8601 if object.birthday
    hash
  end

  def picture_url
    _helpers = ActionController::Base.helpers
    object.picture.exists? ? object.picture.url(:medium) : _helpers.image_path("no_picture_medium.png")
  end
end