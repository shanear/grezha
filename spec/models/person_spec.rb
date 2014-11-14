require "spec_helper"

describe User do
  it "should error on blank name" do
    User.new(name: "").should have(1).errors_on(:name)
  end

  it "should error on blank role" do
    User.new(role: "").should have(1).errors_on(:email)
  end
end
