require 'spec_helper'

module DHT
  describe Hash do
    fake(:manager)
    fake(:storage)
    fake(:storage2) { Storage }
    fake(:dcell_node) { DCell::Node }

    before do
      fake_class(DHT::Node, :new => dcell_node)
      stub(dcell_node).[](:storage) { storage }
      stub(dcell_node).[](:manager) { manager }
      stub(manager).storage_for(:key) { storage }
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
      it "store value in storage" do
        mock(storage).store(:key, :value)  { :value }
        subject.store(:key, :value).should == :value
      end

      it "store key in another node" do
        mock(manager).storage_for(:key) { storage2 }
        mock(storage2).store(:key, :value) { :value }

        subject.store(:key, :value).should == :value
      end
    end

    describe "#[]" do
      it "gets key from current node" do
        mock(storage).get(:key) { :value }
        mock(manager).storage_for(:key) { storage }

        subject[:key].should == :value
      end

      it "cannot find key on closets node" do
        mock(storage).get(:key) { nil }
        mock(manager).storage_for(:key) { storage }

        subject[:key].should == nil
      end

      it "get key from other node" do
        mock(manager).storage_for(:key) { storage2 }
        mock(storage2).get(:key) { :value }

        subject[:key].should == :value
      end
    end
  end
end