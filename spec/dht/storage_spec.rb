require 'spec_helper'

module DHT
  describe Storage do
    fake(:key)
    subject { Storage.new(key) }

    it "saves key and value to database" do
      subject.store(:key, "value")

      subject.database.keys.should include(:key)
      subject.database.values.should include("value")
      subject.database[:key].should == "value"
    end

    it "saves to database with #[]= method" do
      subject[:key] = "value"

      subject.database[:key].should == "value"
    end

    it "reads from database with #[] method" do
      subject[:key] = "value"

      subject[:key].should == "value"
    end
  end
end