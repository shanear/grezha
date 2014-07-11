# == Schema Information
#
# Table name: connections
#
#  id              :integer          not null, primary key
#  note            :text
#  contact_id      :integer
#  created_at      :datetime
#  updated_at      :datetime
#  occurred_at     :datetime
#  remote_id       :string(8)        not null
#  organization_id :integer
#

class Connection < ActiveRecord::Base
  include RemoteSynced

  belongs_to :contact
  validates :contact, presence: true
  validate  :contact_organization_matches

  private

  # TODO: if this triggers, it means we might be getting hacked.
  #       don't worry about user friendly error messages...
  #       this should error & possibily send us an email
  def contact_organization_matches
    if contact && contact.organization_id != organization_id
      errors.add(:contact, "must have the same organization")
    end
  end
end
