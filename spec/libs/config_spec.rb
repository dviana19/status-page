require "spec_helper"

RSpec.describe Config do
  subject { described_class.new }

  context "when file exists" do
    context "without scope" do
      it { expect(subject.services.size).to eq 6 }
      it { expect(subject.services.map{|s| s["name"]}).to match_array %w(Bitbucket Cloudflare Rubygems Github Dropbox Intercom) }
      it { expect(subject.interval).to eq 5 }
    end
    context "with scope" do
      subject { described_class.new("github") }
      it { expect(subject.services.size).to eq 1 }
      it { expect(subject.services.map{|s| s["name"]}).to match_array %w(Github) }
    end
    context "with an inexistent scope" do
      subject { described_class.new("unknown") }
      it { expect(subject.services.size).to eq 6 }
      it { expect(subject.services.map{|s| s["name"]}).to match_array %w(Bitbucket Cloudflare Rubygems Github Dropbox Intercom) }
    end
  end
  context "when file does not exists" do
    before { stub_const("Config::FILEPATH", "no_file.yml") }
    it { expect(subject.services).to match_array [] }
    it { expect(subject.interval).to eq 3 }
  end
end
