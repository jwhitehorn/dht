require "spec_helper"

module DHT
  describe Manager do
    let(:key)     { Key.for_content("key") }
    let(:node)    { fake(:addr => "127.0.0.1") }
    let(:node2)   { fake }

    fake(:storage,  :key => Key.for_content("node"))
    fake(:storage2, :key => Key.for_content("node2")) { Storage }
    fake(:manager)

    before do
      stub(storage).key         { key }
      stub(node).[](:storage)   { storage }
      stub(node2).[](:storage)  { storage2 }
      stub(node2).[](:manager)  { manager }
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
        stub(subject).node_for(:key) { node }
        stub(storage).store(:key, :value) { :value }

        subject.store(:key, :value).should == :value
      end

      it "try store key in another node" do
        stub(subject).node_for(:key) { node2 }
        stub(manager).store(:key, :value) { :value }

        subject.store(:key, :value).should == :value
      end
    end

    describe "#get" do
      it "get key from current node" do
        stub(subject).node_for(:key) { node }
        stub(storage).[](:key) { :value }

        subject.get(:key).should == :value
      end

      it "cannot find key on closets node" do
        stub(subject).node_for(:key) { node }
        stub(storage).[](:key) { nil }

        subject.get(:key).should == "There is no such key (#{:key})"
      end

      it "get key from other node" do
        stub(subject).node_for(:key) { node2 }
        stub(storage).[](:key) { nil }
        stub(manager).get(:key) { :value }

        subject.get(:key).should == :value
      end
    end

    describe "#node_for" do
      before { stub(subject).dcell_nodes { [node, node2] } }

      it "find closets node for :key" do
        subject.node_for(:key).should == node
      end

      it "find closets node for :key_2" do
        subject.node_for(:key22).should == node2
      end
    end
  end
end
