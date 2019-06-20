require "spec_helper"

RSpec.describe Spider do
  subject { described_class.new("page.html") }

  let(:html) { '<div class="page-status status-none"><span class="status font-large">All Systems Operational</span><span class="last-updated-stamp  font-small"></span></div>' }
  before     { allow_any_instance_of(Spider).to receive(:open).with(anything).and_return(html) }

  describe "#get_status_content" do
    context "when there is status" do
      it { expect(subject.get_status_content).to eq "All Systems Operational" }
    end
    context "when status is not found" do
      let(:html) { "<div></div>" }
      it { expect(subject.get_status_content).to eq "Invalid response" }
    end
  end
end
