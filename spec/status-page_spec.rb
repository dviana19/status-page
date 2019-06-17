require "rspec"
require_relative "../status-page"

RSpec.describe StatusPage do
  describe "#add" do
    it "returns the sum of its arguments" do
      expect(StatusPage.new.pull).to be nil
    end
    it "returns the sum of its arguments" do
      expect(StatusPage.new.live).to be nil
    end
    it "returns the sum of its arguments" do
      expect(StatusPage.new.history).to be nil
    end
    it "returns the sum of its arguments" do
      expect(StatusPage.new.backup("/")).to be nil
    end
    it "returns the sum of its arguments" do
      expect(StatusPage.new.restore("/")).to be nil
    end
  end
end
