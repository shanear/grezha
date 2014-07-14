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
    it 'should return users associated with current users organization' do
      get :index
      expect(assigns :users).to have(2).items
    end

  end

  describe "GET #new" do

    let(:organization_one) {Organization.create!(name: "Awesome Possum Club")}
    let(:user_one) {FactoryGirl.create(:user, name: 'user_one', organization_id: organization_one.id)}

    it 'should return a blank user' do
      get :new
      expect(assigns :user).not_to be_nil
    end
  end

  describe "POST #create" do

    let(:organization_one) {Organization.create!(name: "Awesome Possum Club")}
    let(:user_one) {FactoryGirl.create(:user, name: 'user_one', organization_id: organization_one.id)}
    let(:user_json) {Hash[user: Hash[name: 'some_name', password: 'default_password', email: 'default@email.com']]}
    let(:invalid_password_user) {Hash[user: Hash[name: 'some_name', password: 'pass', email: 'default@email.com']]}


      it 'should create a user' do
        post :create, user_json
        new_user = User.where(name: 'some_name').first
        expect(new_user).to_not be_nil
        expect(new_user.organization_id).to eq user_one.organization_id
      end

      it "should redirect to new if bad user" do
        user_count_before = User.count
        expect(post :create, invalid_password_user).to redirect_to new_user_path
        expect(User).to have(user_count_before).items
      end

      it "should assign errors if bad user" do
        post :create, invalid_password_user
        expect(assigns :errors).to have(1).items
      end


    end


end
