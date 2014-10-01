require 'spec_helper'

RSpec.describe PinCashout::Transfer do
  describe "#new" do
    it "requires an amount" do
      expect{ described_class.new }.to raise_error KeyError, "key not found: :amount"
    end

    describe "default values" do
      let(:subject) { described_class.new(amount: 400) }

      it "has a default currency of AUD" do
        expect(subject.currency).to eq 'AUD'
      end

      it "has a default recipient of self" do
        expect(subject.recipient).to eq 'self'
      end

      it "has a default description" do
        expect(subject.description).to eq 'Cashout via PinCashout'
      end
    end

    describe "options" do
      it "accepts an amount" do
        expect(described_class.new(amount: 400).amount).to eq 400
      end

      it "accepts a currency" do
        expect(described_class.new(amount: 400, currency: 'USD').currency).to eq 'USD'
      end

      it "accepts a recipient" do
        expect(described_class.new(amount: 400, recipient: '87sfgh9gp').recipient).to eq '87sfgh9gp'
      end

      it "accepts a description" do
        expect(described_class.new(amount: 400, description: 'this transfer').description).to eq 'this transfer'
      end
    end
  end

  context "when successfully communicating with the Pin API" do
    let(:subject) { described_class.new(amount: 400, recipient: 'rp_a98a4fafROQCOT5PdwLkQ', currency: 'AUD', description: 'Earnings for may') }


    describe "#process!" do
      it "transfers the amount to the user's account" do
        VCR.use_cassette('transfer') do
          subject.process!

          expect(subject.response_status).to eq 201
          expect(subject.response_amount).to eq 400
        end
      end
    end


  end
end
