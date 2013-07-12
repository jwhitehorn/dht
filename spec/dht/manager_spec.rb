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
      stub(node).[](:manager)   { manager }
      stub(node2).[](:storage)  { storage2 }
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

    describe "#storage_for" do
      it "returns current node" do
        mock(subject).node_for(:key) { node }

        subject.storage_for(:key).should == storage
      end

      it "returns another node another node" do
        mock(subject).node_for(:key) { node2 }
        mock(manager2).storage_for(:key) { storage2 }

        subject.storage_for(:key).should == storage2
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
