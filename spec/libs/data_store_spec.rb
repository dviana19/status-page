require "spec_helper"

RSpec.describe DataStore do
  subject { described_class }

  describe "#open" do
    after { subject.open }
    context "when file exists" do
      before { allow(File).to receive(:exist?).and_return true }
      it "should open the file with append mode" do
        expect(CSV).to receive(:open).with(anything, "ab")
      end
    end
    context "when file does not exists" do
      before { allow(File).to receive(:exist?).and_return false }
      it "should open the file with write mode" do
        expect(CSV).to receive(:open).with(anything, "wb")
      end
    end
  end

  describe "#read" do
    after { subject.read }
    it "should reads the file with foreach" do
      expect(CSV).to receive(:foreach).with("data/store.csv")
    end
  end

  describe "#backup" do
    after { subject.backup("bkp_path") }
    it "should create a bkp copy in a given path" do
      expect(FileUtils).to receive(:cp).with(anything, /bkp_path/)
    end
  end

  describe "#restore" do
    after { subject.restore("restore_path") }
    it "should restore a bkp copy from a given path" do
      expect(FileUtils).to receive(:cp).with(/restore_path/, anything)
    end
  end

end
