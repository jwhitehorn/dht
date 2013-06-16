require "spec_helper"

module DHT
  describe Node do
    let(:name)      { "default" }
    let(:address)   { "127.0.0.1" }
    let(:port)      { 3000 }
    let(:explorer)  { false }
    let(:options)   { {:name => name, :host => address, :port => port, :explorer => explorer} }

    subject { Node.new(options) }

    describe "#configuration" do
      it "returns configuration for DCell" do
        node = Node.new
        node.configuration[:id].should == name
        node.configuration[:addr].should == "tcp://#{address}:#{port}"
        node.configuration[:directory].should be_nil
      end

      context "custom name" do
        let(:name) { "custom_name" }

        it "returns custom node name for DCell" do
          subject.configuration[:id].should == name
        end
      end

      context "custom address" do
        let(:address) { "google.com" }

        it "returns custom address for DCell" do
          subject.configuration[:addr].should == "tcp://#{address}:#{port}"
        end
      end

      context "custom port" do
        let(:port) { 9000 }

        it "returns custom port for DCell" do
          subject.configuration[:addr].should == "tcp://#{address}:#{port}"
        end
      end
    end

    describe "#key" do
      its(:key) { should == Key.new(Digest::SHA1.digest("#{name}:#{address}:#{port}")) }
    end

    describe "#start" do
      fake_class(DCell)
      fake(:service)

      before do
        stub(service).run { true }
        stub(DHT::Service).new(:key => subject.key, :explorer => explorer) { service }
      end

      it "start DCell node" do
        subject.start
      end

      it "start DHT::Service" do
        service.run.should == true
      end
    end
  end
end