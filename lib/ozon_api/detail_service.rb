# frozen_string_literal: true
module OzonApi
  class DetailService
    BASE_PATH = 'DetailService'

    def initialize(client)
      @client = client
    end

    def detail_get(id)
      @client.get([BASE_PATH, 'DetailGet'].join('/'), 'detailId': id)
    end
  end
end
