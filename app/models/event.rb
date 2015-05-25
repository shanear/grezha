class Event < ActiveRecord::Base
  include RemoteSynced

  belongs_to :program
end
