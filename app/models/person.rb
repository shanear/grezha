class Person < ActiveRecord::Base
  include RemoteSynced

  has_many :relationships

  validates :name, presence: true
  validates :role, presence: true
end
