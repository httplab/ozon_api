# frozen_string_literal: true
require 'spec_helper'
require 'shared_contexts/having_configured_client'

describe OzonApi::AddressService do
  include_context 'having configured client'

  let(:subject) { described_class.new(client) }

  let(:vcr_options) do
    ['address_service', { record: :new_episodes, match_requests_on: [:method, :uri] }]
  end

  describe '#search_cities' do
    let(:search_text) { 'Рост' }

    it 'returns a list of cities' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.search_cities(search_text: search_text) }
      end
    end
  end

  describe '#get_cities' do
    let(:city_ids) { [9796, 927, 29307] }

    it 'returns a list of cities info' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.get_cities(city_ids: city_ids) }
      end
    end
  end

  describe '#search_streets' do
    let(:city_id) { 9796 }
    let(:search_text) { '1-й Конной Армии' }

    it 'returns a list of streets' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.search_streets(
            city_id: city_id,
            search_text: search_text,
            search_text_match_preferred: false
          )
        end
      end
    end
  end
end
