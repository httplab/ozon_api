# frozen_string_literal: true
require 'spec_helper'
require 'shared_contexts/having_configured_client'

describe OzonApi::CartService do
  include_context 'having configured client'

  let(:partner_client_id) { 'hb1' }

  let(:vcr_options) do
    ['cart_service', { record: :once, match_requests_on: [:method, :uri] }]
  end

  describe '#cart_get' do
    it 'returns cart items' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.cart_get(partner_client_id: partner_client_id) }
      end
    end
  end

  describe '#cart_add' do
    let(:cart_items) do
      [
        { partner_id: 33_040_906, quantity: 1 },
        { partner_id: 33_040_907, quantity: 2 },
        { partner_id: 33_040_908, quantity: 3 }
      ]
    end

    it 'adds items to cart and returns order url' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.cart_add(
            partner_client_id: partner_client_id,
            cart_items: cart_items
          )
        end
      end
    end
  end

  describe '#cart_remove' do
    it 'removes items from cart' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.cart_remove(
            partner_client_id: partner_client_id,
            cart_item_ids: [33_040_906, 33_040_907, 33_040_908]
          )
        end
      end
    end
  end
end
