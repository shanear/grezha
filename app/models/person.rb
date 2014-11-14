class Person < ActiveRecord::Base
  include RemoteSynced

  has_many :relationships

  validate :name, :presence :true
  validate :role, :presence :true
end
