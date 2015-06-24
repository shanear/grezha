class Event < ActiveRecord::Base
  include RemoteSynced

  belongs_to :program
  has_many :registrations
end
