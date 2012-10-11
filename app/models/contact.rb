class Contact < ActiveRecord::Base
  attr_accessible :bio, :birthday, :name, :picture

  has_attached_file :picture,
    styles: { medium: "200", thumb: "50x50#" },
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV["S3_ACCESS_KEY_ID"],
      secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
      bucket: "daughters_contacts"
    }
end
