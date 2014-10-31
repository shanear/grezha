require "spec_helper"

describe User do
  it "should error on blank name" do
    User.new(name: "").should have(1).errors_on(:name)
  end

  it "should error on blank email" do
    User.new(email: "").should have(1).errors_on(:email)
  end

  it "should error on blank or short password" do
    User.new(password: "").should have(2).errors_on(:password)
    User.new(password: "111").should have(1).errors_on(:password)
  end

  context "on update" do
    let(:user) { FactoryGirl.create(:user) }

    it "should allow changes" do
      user.update(name: "Verne").should be_true
    end

    it "allows password changes" do
      user.update(
        password: "1337p@ssword",
        password_confirmation: "1337p@ssword"
      ).should be_true
    end

    it "rejects password unless confirmed" do
      user.update(
        password: "1337p@ssword",
        password_confirmation: "1337password"
      ).should be_false
    end
  end

  context :admin do
    it "verifies a role of admin" do
      User.new(role: "admin").should be_admin
    end
    it "verifies a role of user" do
      User.new(role: "user").should_not be_admin
    end
  end
end
