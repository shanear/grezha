class OfflineController < ApplicationController
  before_filter :require_logged_in

  def app
  end

  def manifest
    render layout: false
  end
end