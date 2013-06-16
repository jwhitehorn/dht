require 'spec_helper'

module DHT
  describe Hash do
    fake(:manager)
    fake(:storage)
    fake(:dcell_node) { DCell::Node }

    before do
      fake_class(DHT::Node, :new => dcell_node)
      stub(dcell_node).[](:storage) { storage }
      stub(dcell_node).[](:manager) { manager }
      stub(manager).store(any_args, :value) { :value }
      stub(manager).get(:key) { :value }
      stub(subject).me { dcell_node }
    end

    describe "#me" do
      it "returns current node" do
        subject.me.should == dcell_node
      end
    end

    describe "#storage" do
      it "returns storage of node" do
        subject.storage.should == storage
      end
    end

    describe "#manager" do
      it "it returns manager of node" do
        subject.manager.should == manager
      end
    end

    describe "#[]=" do
      it "ask manager to store value" do
        (subject[:key] = :value).should == :value
        manager.shold have_received.store(:key, :value) { :value }
      end
    end

    describe "#[]" do
      it "ask manager to get value for key" do
        subject[:key].should == :value
        manager.should have_received.get(:key) { :value }
      end
    end
  end
end