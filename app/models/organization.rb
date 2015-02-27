# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Organization < ActiveRecord::Base
  def roles
    return ["admin", "field-op", "volunteer"] if contra_costa?
    ["user", "admin"]
  end

  def contra_costa?
    name == "Contra Costa Reentry Network" || name == "Kool Klub"
  end
end
