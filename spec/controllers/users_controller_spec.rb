require 'spec_helper'

describe UsersController do

  before do
    auth_with_user(user_one)
  end

  describe "GET #index" do

    let(:organization_one) {Organization.create!(name: "Awesome Possum Club")}
    let(:organization_two) {Organization.create!(name: "Less Awesome Possum Club")}
    let(:user_one) {FactoryGirl.create(:user, name: 'user_one', organization_id: organization_one.id)}
    let(:user_two) {FactoryGirl.create(:user, name: 'user_two', organization_id: organization_one.id)}
    let(:user_three) {FactoryGirl.create(:user, name: 'user_three', organization_id: organization_two.id)}

    before {[user_one, user_two, user_three]}
    it 'shoule return users associated with current users organization' do
      get :index
      expect(assigns :users).to have(2).items
    end

  end

end
