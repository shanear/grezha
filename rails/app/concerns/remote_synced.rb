module RemoteSynced
  extend ActiveSupport::Concern

  included do
    before_create :populate_remote_id
  end

  private

  def populate_remote_id
    self.remote_id ||= generate_remote_id
  end

  def generate_remote_id
    SecureRandom.base64(4).tr('+/=', '012')
  end
end