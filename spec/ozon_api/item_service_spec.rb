# frozen_string_literal: true
require 'spec_helper'
require 'shared_contexts/having_configured_client'

describe OzonApi::ItemService do
  include_context 'having configured client'
  let(:subject) { described_class.new(client) }
  let(:vcr_options) do
    [
      'item_service',
      {
        record: :new_episodes,
        match_requests_on: [:method, :uri]
      }
    ]
  end

  describe '#item_get' do
    it 'returns item info' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.item_get('33040909') }
      end
    end
  end
end
