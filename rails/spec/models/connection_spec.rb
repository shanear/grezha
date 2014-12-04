require "spec_helper"

describe Connection do
  let(:connection) { FactoryGirl.build(:connection) }

  context ".valid?" do
    context "when no contact" do
      it "is invalid" do
        connection.contact = nil
        expect(connection).to_not be_valid
      end
    end

    context "when contact organization doesn't match" do
      it "is invalid" do
        connection.contact.organization_id = connection.organization_id + 1
        expect(connection).to_not be_valid
      end
    end
  end

  context ".save" do
    context "when no remote_id is provided" do
      it "automatically populates it with a valid id" do
        connection = FactoryGirl.build(:connection, remote_id: nil)

        connection.save!
        expect(connection.remote_id).to match(/[A-Za-z0-9]{8}/)
      end
    end
  end
end