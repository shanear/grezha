class OfflineController < ApplicationController
  def app
  end

  def manifest
    render layout: false
  end
end