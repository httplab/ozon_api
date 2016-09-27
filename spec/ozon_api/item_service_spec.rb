# frozen_string_literal: true
require 'spec_helper'
require 'shared_contexts/having_configured_client'

describe OzonApi::ItemService do
  include_context 'having configured client'
  let(:subject) { described_class.new(client) }
  let(:partner_client_id) { 1 }
  let(:vcr_options) do
    [
      'item_service',
      {
        record: :new_episodes,
        match_requests_on: [:method, :uri]
      }
    ]
  end

  describe '#item_availabilities_get' do
    it 'returns availabilities list' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.item_availabilities_get }
      end
    end
  end

  describe '#item_get' do
    let(:item_id) { '33040909' }

    it 'returns item info' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.item_get(item_id) }
      end
    end
  end

  describe '#items_by_id_list_get' do
    let(:item_ids) { ['33040907', '33040908', 33_040_909] }

    it 'returns items info' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.items_by_id_list_get(
            item_ids: item_ids,
            page_number: 1,
            only_for_sale: false,
            partner_client_id: partner_client_id
          )
        end
      end
    end
  end
end
