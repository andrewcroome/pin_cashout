require 'spec_helper'

RSpec.describe PinCashout::Balance do
  context "when successfully communicating with the Pin API" do
    describe "#available_balance" do
      it "returns the available balance of the Pin account" do
        VCR.use_cassette('balance') do
          expect(subject.available_balance).to eq 400
        end
      end
    end

    describe "#available_currency" do
      it "returns the currency of the available balance" do
        VCR.use_cassette('balance') do
          expect(subject.available_currency).to eq 'AUD'
        end
      end
    end

    describe "#pending_balance" do
      it "returns the pending balance of the Pin account" do
        VCR.use_cassette('balance') do
          expect(subject.pending_balance).to eq 1200
        end
      end
    end

    describe "#pending_currency" do
      it "returns the currency of the pending balance" do
        VCR.use_cassette('balance') do
          expect(subject.pending_currency).to eq 'AUD'
        end
      end
    end
  end

  context "when the response from Pin is unsuccessful" do
    describe "#available_balance" do
      it "raises a ResourceNotFound error when Pin responds with 404" do
        VCR.use_cassette('balance_404_error') do
          expect{ subject.available_balance }.to raise_error PinCashout::Error::ResourceNotFound
        end
      end
    end
  end
end
