class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :email, :name, :password

  # TODO: validate email
  validates :password, :presence => true, :length => { :within => 6..40 }

  before_save :normalize_email
  before_save :encrypt_password
  before_save :generate_remember_token

  def has_password?(password)
    encrypted_password == encrypt(password)
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    (user && user.has_password?(password)) ? user : nil
  end

  private

  def normalize_email
    self.email = email.downcase
  end

  def encrypt_password
    self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--rolltide")
    self.encrypted_password = encrypt(password)
  end

  def generate_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def encrypt(string)
    Digest::SHA2.hexdigest("#{salt}--#{string}")
  end
end
