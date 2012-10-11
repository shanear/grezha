class Contact < ActiveRecord::Base
  attr_accessible :bio, :birthday, :name, :picture

  has_attached_file :picture, :styles => { :medium => "200", :thumb => "50x50#" }
end
