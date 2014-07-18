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

  describe "POST #create" do
    let(:organization_one) {Organization.create!(name: "Awesome Possum Club")}
    let(:user_one) {FactoryGirl.create(:user, name: 'user_one', organization_id: organization_one.id)}
    let(:user_json) {Hash[user: Hash[name: 'some_name', role: "role", password: 'default_password', email: 'default@email.com']]}
    let(:invalid_password_user) {Hash[user: Hash[name: 'some_name', password: 'secr', email: 'default@email.com']]}

    context "when valid" do
      it 'creates a user' do
        post :create, user_json
        new_user = User.where(name: 'some_name').first

        expect(new_user).to_not be_nil
        expect(new_user.organization_id).to eq user_one.organization_id
        expect(new_user.role).to eq "role"
      end
    end

    context "when invalid" do
      it "renders new" do
        expect {
          expect(post :create, invalid_password_user).to render_template(:new)
        }.not_to change(User, :count)
      end

      it "assigns errors" do
        post :create, invalid_password_user

        expect(assigns(:user).errors).to have(1).items
      end

      it "clears password" do
        post :create, invalid_password_user

        expect(assigns(:user).password).to be_blank
      end
    end
  end
end
