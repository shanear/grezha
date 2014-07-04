class Api::V1::RelationshipsController < ApplicationController
  before_filter :require_logged_in
  respond_to :json

  

end