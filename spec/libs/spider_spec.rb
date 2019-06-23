require "spec_helper"

RSpec.describe Spider do
  subject { described_class.pull(services) }

  describe "#pull" do
    context "when there are no services" do
      let(:services) { [] }
      it { expect(subject).to match_array [] }
    end
    context "when there are services" do
      let(:services) { [{ "name" => "Github", "address" => "https://www.github1status.com/" }] }
      before         { allow_any_instance_of(Spider).to receive(:open).with(anything).and_return(html) }
      context "when it is a valid status page" do
        let(:html) { '<div class="page-status status-none"><span class="status font-large">All Systems Operational</span><span class="last-updated-stamp  font-small"></span></div>' }
        it { expect(subject).to match_array [["Github", "Up", "All Systems Operational", Time.now.to_i]] }
      end
      context "when it is an invalid status page" do
        let(:html) { "<div></div>" }
        it { expect(subject).to match_array [["Github", "Down", "Status unknown", Time.now.to_i]] }
      end
      context "when it is an invalid address" do
        let(:html) { nil }
        before { allow_any_instance_of(Spider).to receive(:open).with(anything).and_raise(Exception, "Failed to open TCP connection") }
        it { expect(subject).to match_array [["Github", "Down", "Failed to open TCP connection", Time.now.to_i]] }
      end
    end
  end
end
