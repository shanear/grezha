require "spec_helper"

describe Person do
  it "should error on blank name" do
    Person.new(name: "").should have(1).errors_on(:name)
  end

  it "should error on blank role" do
    Person.new(role: "").should have(1).errors_on(:role)
  end
end
