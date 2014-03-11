class ConnectionSerializer < ActiveModel::Serializer
  attributes :id, :note, :date, :contact_id

  def attributes
    hash = super
    # Adding 12 hours to date is a hacky way to avoid parsing wrong date because of timezones
    # TODO: really need to look into solving this problem
    hash['date'] = (object.date.to_datetime + 12.hours).iso8601 if object.date
    hash
  end
end