require "spec_helper"

describe Contact do
  context ".create" do
    context "when no remote_id is provided" do
      it "automatically populates it with a valid id" do
        contact = Contact.create(name: "Nick Saban")
        expect(contact.remote_id).to match(/[A-Za-z0-9]{8}/)
      end
    end
  end

  context ".with_recent_birthday" do
    it "returns contacts with birthdays up to 14 days ago" do
      Timecop.freeze(DateTime.new(2014, 1, 1)) do
        recent = FactoryGirl.create(:contact, birthday: Time.now - 13.days)
        not_recent = FactoryGirl.create(:contact, birthday: Time.now - 16.days)
        upcoming = FactoryGirl.create(:contact, birthday: Time.now + 1.day)

        recent_contacts = Contact.with_recent_birthday

        recent_contacts.should be_include(recent)
        recent_contacts.should_not be_include(not_recent)
        recent_contacts.should_not be_include(upcoming)
      end
    end
  end

  context ".with_upcoming_birthday" do
    it "returns contacts with birthdays up to 14 days ago" do
      Timecop.freeze(DateTime.new(2013, 12, 31)) do
        current = FactoryGirl.create(:contact, name: "current", birthday: Time.now)
        upcoming = FactoryGirl.create(:contact, name: "upcoming", birthday: Time.now + 1.day)
        not_upcoming = FactoryGirl.create(:contact, name: "not upcoming", birthday: Time.now + 15.days)
        recent = FactoryGirl.create(:contact, name: "recent", birthday: Time.now - 2.days)

        recent_contacts = Contact.with_upcoming_birthday

        recent_contacts.should == [current, upcoming]
        recent_contacts.should_not be_include(not_upcoming)
        recent_contacts.should_not be_include(recent)
      end
    end
  end
end