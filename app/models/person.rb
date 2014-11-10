class Person < ActiveRecord::Base
  include RemoteSynced

  has_many :relationships
end
