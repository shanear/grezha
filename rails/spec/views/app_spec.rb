require 'spec_helper'

describe 'offline/app' do
  before do
    user = User.new(:name => "Sophie")
    user.organization = Organization.new(:name => "TW")
    user.role = "admin"
    view.stub(:current_user).and_return(user)
    render
  end

  it 'should inject the users name' do
    expect(view.content_for(:javascript_setup)).to include "Sophie"
  end

  it 'should inject the admin rights' do
    expect(view.content_for(:javascript_setup)).to include "true"
  end
end