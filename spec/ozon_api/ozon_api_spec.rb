# frozen_string_literal: true
require 'spec_helper'

describe OzonApi do
  before(:each) do
    OzonApi.reset
  end

  describe '.setup' do
    context 'given default configuration options' do
      it 'initializes gem config using env variables' do
        expect(described_class.setup).to be_a(OzonApi::Configuration)
      end
    end

    context 'given blank configuration options' do
      it 'raises an exception' do
        expect do
          described_class.setup do |c|
            c.login = ''
            c.password = ''
          end
        end.to raise_error(OzonApi::InvalidConfigurationError)
      end
    end
  end

  context 'given configuration' do
    before(:each) do
      OzonApi.setup
    end

    describe '.client' do
      it 'returns an instance of ozon client' do
        expect(described_class.client).to be_a(OzonApi::Client)
      end
    end

    [
      :item,
      :detail,
      :client,
      :cart,
      :checkout,
      :order,
      :address
    ].each do |name|
      describe ".#{name}_service" do
        it 'returns an instance of service' do
          expect(described_class.public_send("#{name}_service").class.name).to eq("OzonApi::#{name.capitalize}Service")
        end
      end
    end
  end
end
