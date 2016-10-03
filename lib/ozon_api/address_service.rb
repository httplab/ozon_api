# frozen_string_literal: true
module OzonApi
  class AddressService
    BASE_PATH = 'AddressService'

    def initialize(client)
      @client = client
    end

    def search_cities(search_text:, limit: 20)
      @client.get(
        [BASE_PATH, 'SearchCities'].join('/'),
        'searchText': search_text,
        'limit': limit
      )
    end

    def get_cities(city_ids:)
      @client.get(
        [BASE_PATH, 'GetCities'].join('/'),
        'citiIds': city_ids.map(&:to_s).join(',')
      )
    end

    def search_streets(
          city_id:,
          search_text:,
          search_text_match_preferred:,
          limit: 20
    )
      @client.get(
        [BASE_PATH, 'SearchStreets'].join('/'),
        'cityId': city_id,
        'searchText': search_text,
        'searchTextMatchPreferred': search_text_match_preferred,
        'limit': limit
      )
    end
  end
end
