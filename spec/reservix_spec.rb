require "spec_helper"

describe Reservix do

  it "raises ArgumentError when initialized with no options" do
    expect{ Reservix.new }.to raise_error(ArgumentError)
  end

  context 'initialized with a api_key' do
    subject{Reservix.new(:api_key => 'key')}

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

    describe "#api_module" do
      it { expect(subject.api_module).to eq "sale" }
    end

    describe "#api_host" do
      it { expect(subject.api_host).to eq("api.reservix.de") }
    end

    describe "#api_url" do
      it { expect(subject.api_url).to eq("api.reservix.de/1/sale")}
    end

    [:get, :delete, :head].each do |method|
      describe "##{method}" do
        it "accepts urls as path and rewrite them" do
          expect(Reservix::Client).to receive(method).with('https://api.reservix.de/1/sale/event/123', { query: { format: "json", "api-key" => 'key'}})
          subject.send(method, "/event/123")
        end

        it "accepts additional query parameters" do
          expect(Reservix::Client).to receive(method).with('https://api.reservix.de/1/sale/event/123', {query: { limit: 2, "api-key" => 'key', format: "json"}})
          subject.send(method, '/event/123', limit: 2)
        end

        it "wraps the response object in a Response" do
          stub_request(method, "https://api.reservix.de/1/sale/event/123").
            with(:query => {:format => "json", "api-key" => "key"}, :headers => {'User-Agent'=>'ASK HELMUT Reservix API Wrapper 0.0.3'}).
            to_return(:body => '{"title": "bla"}', :headers => {:content_type => "application/json"})
          expect(subject.send(method, '/event/123')).to be_an_instance_of Reservix::HashResponseWrapper
        end
      end
    end

    [:post, :put].each do |method|
      describe "##{method}" do

      end
    end
  end

end
