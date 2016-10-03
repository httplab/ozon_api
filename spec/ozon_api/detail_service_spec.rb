# frozen_string_literal: true
require 'spec_helper'
require 'shared_contexts/having_configured_client'

describe OzonApi::DetailService do
  include_context 'having configured client'
  let(:detail_id) { '33040909' }
  let(:vcr_options) do
    [
      'detail_service',
      {
        record: :once,
        match_requests_on: [:method, :uri]
      }
    ]
  end

  describe '#detail_get' do
    it 'returns item details' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.detail_get(detail_id) }
      end
    end
  end
end
