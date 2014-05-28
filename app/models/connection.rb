class Connection < ActiveRecord::Base
  include RemoteSynced
  belongs_to :contact
end
