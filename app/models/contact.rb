class Contact < ActiveRecord::Base
  attr_accessible :bio, :birthday, :name, :picture, :city, :last_seen

  has_attached_file :picture,
    styles: { medium: "200", thumb: "50x50#" }

  scope :with_birthday_month, ->(month_num) {
    where("DATE_PART('month', birthday) = #{month_num}")
  }
end
