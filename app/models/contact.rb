class Contact < ActiveRecord::Base
  has_many :children

  accepts_nested_attributes_for :children, reject_if: ->(a) { a[:name].blank? }

  has_attached_file :picture,
    styles: { medium: "200", thumb: "50x50#" }

  scope :with_birthday_month, ->(month_num) {
    where("DATE_PART('month', birthday) = #{month_num}")
  }
end
