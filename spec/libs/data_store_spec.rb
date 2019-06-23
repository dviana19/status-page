require "spec_helper"

RSpec.describe DataStore do
  subject     { described_class }

  describe "public object methods" do
    let(:file)  { "store_test.csv" }
    before      { stub_const("DataStore::FILE", file) }
    after       { File.delete("data/#{file}") if File.exist?("data/#{file}")  }
    subject     { described_class.new }

    describe "#save" do
      context "where there is data to save" do
        let(:data) { [["Github", "http://github.url.com", Time.now.to_i]] }
        it { expect(subject.save(data)).to be_a(Array) }
        it { expect(subject.save(data).size).to eq 1 }
      end
      context "when there is no data" do
        let(:data) { [] }
        it { expect(subject.save(data)).to be_a(Array) }
        it { expect(subject.save(data).size).to eq 0 }
      end
    end
  end

  describe "public class methods" do
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
end
