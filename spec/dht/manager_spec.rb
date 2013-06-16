require "spec_helper"

module DHT
  describe Manager do
    let(:nodes) { {} }

    subject { Manager.new }

    before do
      fake_class(DCell::Node, all: nodes)
    end

    describe "#nodes" do
      it "returns DCell nodes" do
        subject.nodes.should == { }
      end
    end
  end
end
