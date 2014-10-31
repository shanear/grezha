# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  remember_token     :string(255)
#  salt               :string(255)
#  encrypted_password :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  organization_id    :integer
#

class User < ActiveRecord::Base
  PEPPER = ENV['SALT_SPICE']

  attr_accessor :password, :password_confirmation
  belongs_to :organization
  has_many :contacts

  # TODO: validate email
  validates_presence_of :name, :email
  validates :password, presence: true, on: :create
  validates :password, confirmation: true,
                       length: { :within => 6..40 },
                       :if => :password

  before_create :generate_remember_token
  before_save :clear_reset_password_token
  before_save :normalize_email
  before_save :encrypt_password, :if => :password

  def has_password?(password)
    encrypted_password == encrypt(password)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    (user && user.has_password?(password)) ? user : nil
  end

  def self.roles
    ["user", "admin"]
  end

  def admin?
    return self.role.to_sym == :admin
  end

  def generate_password_reset
    self.reset_password_token = SecureRandom.urlsafe_base64
  end

  private

  def normalize_email
    self.email = email.downcase
  end

  def encrypt_password
    self.salt = Digest::SHA2.hexdigest(Time.now.utc.to_s)
    self.encrypted_password = encrypt(password)
  end

  def generate_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def clear_reset_password_token
    unless self.reset_password_token_changed?
      self.reset_password_token = nil
    end
  end

  def encrypt(string)
    Digest::SHA2.hexdigest("#{salt}--#{PEPPER}--#{string}")
  end
end
