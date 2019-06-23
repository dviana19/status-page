require "spec_helper"

RSpec.describe Presenter do
  subject     { described_class.new }

  describe "#header" do
    it { expect(subject.header).to include("Service", "Status", "Message", "Time") }
  end
  describe "#show" do
    context "when there is data show" do
      let(:data) { [["Github", "Up", "All Systems Operational", Time.now.to_i]] }
      it { expect(subject.show(data)).to include("Up") }
    end
    context "when there is no data to show" do
      let(:data) { [] }
      it { expect(subject.show(data)).to be_empty }
    end
  end
end
