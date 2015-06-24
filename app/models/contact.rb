# == Schema Information
#
# Table name: contacts
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  bio                  :text
#  birthday             :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  city                 :string(255)
#  last_seen            :date
#  remote_id            :string(8)        not null
#  organization_id      :integer
#

class Contact < ActiveRecord::Base
  include RemoteSynced

  has_many :connections, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :registrations, dependent: :destroy
  belongs_to :user

  has_attached_file :picture,
    styles: { medium: "200", thumb: "50x50#" }

  scope :with_birthday_month, ->(month_num) {
    where("DATE_PART('month', birthday) = #{month_num}")
  }

  scope :with_recent_birthday, -> {
    today = Date.today.yday
    recent_cutoff = today - 14

    if(recent_cutoff < 0)
      where("EXTRACT(DOY FROM birthday) < #{today} OR EXTRACT(DOY FROM birthday) >= #{365 + recent_cutoff}")
      .order(:birthday)
    else
      where("EXTRACT(DOY FROM birthday) < #{today} AND EXTRACT(DOY FROM birthday) >= #{recent_cutoff}")
      .order(:birthday)
    end
  }

  scope :with_upcoming_birthday, -> {
    today = Date.today.yday
    upcoming_cutoff = today + 14

    if(upcoming_cutoff > 365)
      where("EXTRACT(DOY FROM birthday) >= #{today} OR EXTRACT(DOY FROM birthday) <= #{upcoming_cutoff - 365}")
      .order(:birthday)
    else
      where("EXTRACT(DOY FROM birthday) >= #{today} AND EXTRACT(DOY FROM birthday) <= #{upcoming_cutoff}")
      .order(:birthday)
    end
  }
end
