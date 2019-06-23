require "spec_helper"

RSpec.describe Config do
  subject { described_class.new }

  context "when file exists" do
    it { expect(subject.services.map{|s| s["name"]}).to match_array %w(Bitbucket Cloudflare Rubygems Github) }
    it { expect(subject.interval).to eq 5 }
  end
  context "when file does not exists" do
    before { stub_const("Config::FILEPATH", "no_file.yml") }
    it { expect(subject.services).to match_array [] }
    it { expect(subject.interval).to eq 3 }
  end
end
