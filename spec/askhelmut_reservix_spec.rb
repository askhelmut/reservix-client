require "spec_helper"

describe AskhelmutReservix do

  it "raises ArgumentError when initialized with no options" do
    expect{ AskhelmutReservix.new }.to raise_error(ArgumentError)
  end

  context 'initialized with a client id' do
    subject{AskhelmutReservix.new(:api_key => 'key')}

    describe "#api_key" do
      it "returns the initialized value" do
        expect(subject.api_key).to eq("key")
      end
    end

    describe "#options" do
      it "includes api:key" do
        expect(subject.options).to include(:api_key)
      end
    end

    describe "#use_ssl?" do
      it { expect(subject.use_ssl?).to be_true }
    end

    describe "#site" do
      it { expect(subject.site).to eq("reservix.de") }
    end

    describe "#host" do
      it { expect(subject.host).to eq("reservix.de") }
    end

    describe "#api_host" do
      it { expect(subject.api_host).to eq("api.reservix.de") }
    end
  end

end
