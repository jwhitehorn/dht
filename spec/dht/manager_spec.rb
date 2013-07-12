require "spec_helper"

module DHT
  describe Manager do
    let(:key)     { Key.for_content("key") }
    let(:node)    { fake(:addr => "127.0.0.1") }
    let(:node2)   { fake }

    fake(:storage,  :key => Key.for_content("node"))
    fake(:storage2, :key => Key.for_content("node2")) { Storage }
    fake(:manager)
    fake(:manager2) { Manager }

    before do
      stub(storage).key         { key }
      stub(node).[](:storage)   { storage }
      stub(node2).[](:storage)  { storage2 }
      stub(node2).[](:manager)  { manager }
      stub(node2).[](:manager)  { manager2 }
      stub(subject).me          { node }
      stub(subject).dcell_nodes { [node] }
    end

    describe "#nodes" do
      it "returns DCell nodes" do
        subject.nodes.should == { key => node }
      end
    end

    describe "#find_nodes" do
      it "find nodes will fill @nodes array" do
        subject.nodes.should == subject.find_nodes
      end
    end

    describe "#key" do
      it "returns key for addr of node" do
        subject.key.should be_kind_of(Key)
        subject.key.to_binary.should == Digest::SHA1.digest(node.addr)
      end
    end

    describe "#store" do
      it "store key in current node" do
        mock(subject).node_for(:key) { node }
        mock(storage).store(:key, :value) { :value }

        subject.store(:key, :value).should == :value
      end

      it "try store key in another node" do
        mock(subject).store(:key, :value) { :value }

        subject.store(:key, :value).should == :value
      end
    end

    describe "#get" do
      it "get key from current node" do
        mock(subject).node_for(:key) { node }
        mock(storage).[](:key) { :value }

        subject.get(:key).should == :value
      end

      it "cannot find key on closets node" do
        mock(subject).node_for(:key) { node }
        mock(storage).[](:key) { nil }

        subject.get(:key).should == nil
      end

      it "get key from other node" do
        mock(subject).node_for(:key) { node2 }
        mock(storage).[](:key) { nil }
        mock(manager2).get(:key) { :value }

        subject.get(:key).should == :value
      end
    end

    describe "#node_for" do
      before { mock(subject).dcell_nodes { [node, node2] } }

      it "find closets node for :key" do
        subject.node_for(:key).should == node
      end

      it "find closets node for :key_2" do
        subject.node_for(:key22).should == node2
      end
    end
  end
end
