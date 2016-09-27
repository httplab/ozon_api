# frozen_string_literal: true
require 'spec_helper'
require 'shared_contexts/having_configured_client'

describe OzonApi::OrderService do
  include_context 'having configured client'

  let(:subject) { described_class.new(client) }
  let(:partner_client_id) { 'hb1' }
  let(:order_number) do
    subject.orders_get(partner_client_id: partner_client_id)['OrderDetails'].first['Number']
  end

  let(:vcr_options) do
    ['order_service', { record: :new_episodes, match_requests_on: [:method, :uri] }]
  end

  describe '#orders_get' do
    it 'returns a list of orders' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.orders_get(partner_client_id: partner_client_id) }
      end
    end
  end

  describe '#order_get' do
    it 'returns an order info' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.order_get(
            partner_client_id: partner_client_id,
            order_number: order_number
          )
        end
      end
    end
  end

  describe '#cancel_reasons_get' do
    it 'returns a list of cancel reasons' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.cancel_reasons_get }
      end
    end
  end

  describe '#order_cancel' do
    let(:reason_id) { 56 }
    let(:items) do
      [
        { partner_id: 33_040_906, quantity: 1 },
        { partner_id: 33_040_908, quantity: 3 }
      ]
    end

    it 'returns a status' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.order_cancel(
            partner_client_id: partner_client_id,
            order_number: order_number,
            items: items,
            reason_id: reason_id
          )
        end
      end
    end
  end
end
