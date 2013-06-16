require "spec_helper"

module DHT
  describe Service do
    let(:key) { Key.for_content("example") }
    let(:explorer) { true }

    subject { Service.new(:explorer => explorer, :key => key) }

    before do
      stub(subject).create_storage
      stub(subject).create_manager
      stub(subject).create_explorer
    end

    it "enables services" do
      subject.run
      subject.should have_received.create_explorer
    end

    describe "disabled explorer" do
      let(:explorer) { false }

      it "does not enable explorer" do
        subject.run
        subject.should_not have_received.create_explorer
      end
    end
  end
end