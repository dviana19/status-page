require "spec_helper"
require "date"

RSpec.describe Stats do
  subject { described_class.summarize(services, data) }
  let(:services) do
    [
      {
        "name" => "Github"
      },
      {
        "name" => "Cloudflare"
      }
    ]
  end

  context "when data is empty" do
    let(:data) { [] }
    it { expect(subject).to eq [["Github", "No uptime", "No down time"], ["Cloudflare", "No uptime", "No down time"]] }
  end
  context "when data is not empty" do
    context "with mix data" do
      let(:data) do
        [
          ["Github","Down","Minor Service Outage", (Time.now - 604800).to_i],
          ["Cloudflare","Down","Minor Service Outage",(Time.now - 518400).to_i],
          ["Cloudflare","Down","Minor Service Outage",(Time.now - 432000).to_i],
          ["Cloudflare","Up","All Systems Operational", (Time.now - 345600).to_i],
          ["Github","Up","All Systems Operational", (Time.now - 259200).to_i],
          ["Github","Up","All Systems Operational", (Time.now - 172800).to_i],
          ["Github","Up","All Systems Operational", (Time.now - 86400).to_i],
          ["Cloudflare","Up","All Systems Operational", (Time.now - 3600).to_i]
        ]
      end
      it { expect(subject).to eq [
        ["Github", "3 days", "4 days"],
        ["Cloudflare", "4 days", "2 days"],
      ]}
    end
    context "with no down time" do
      let(:data) do
        [
          ["Github","Up","All Systems Operational", (Time.now - 604800).to_i],
          ["Cloudflare","Up","All Systems Operational",(Time.now - 518400).to_i],
          ["Cloudflare","Up","All Systems Operational",(Time.now - 432000).to_i],
          ["Cloudflare","Up","All Systems Operational", (Time.now - 345600).to_i],
          ["Github","Up","All Systems Operational", (Time.now - 259200).to_i],
          ["Github","Up","All Systems Operational", (Time.now - 172800).to_i],
          ["Github","Up","All Systems Operational", (Time.now - 86400).to_i],
          ["Cloudflare","Up","All Systems Operational", (Time.now - 3600).to_i]
        ]
      end
      it { expect(subject).to eq [
        ["Github", "1 week", "No down time"],
        ["Cloudflare", "6 days", "No down time"],
      ]}
    end
    context "with no up time" do
      let(:data) do
        [
          ["Github","Down","Minor Service Outage", (Time.now - 604800).to_i],
          ["Cloudflare","Down","Minor Service Outage",(Time.now - 518400).to_i],
          ["Cloudflare","Down","Minor Service Outage",(Time.now - 432000).to_i],
          ["Cloudflare","Down","Minor Service Outage", (Time.now - 345600).to_i],
          ["Github","Down","Minor Service Outage", (Time.now - 259200).to_i],
          ["Github","Down","Minor Service Outage", (Time.now - 172800).to_i],
          ["Github","Down","Minor Service Outage", (Time.now - 86400).to_i],
          ["Cloudflare","Down","Minor Service Outage", (Time.now - 3600).to_i]
        ]
      end
      it { expect(subject).to eq [
        ["Github", "No uptime", "7 days"],
        ["Cloudflare", "No uptime", "6 days"],
      ]}
    end
  end
end
