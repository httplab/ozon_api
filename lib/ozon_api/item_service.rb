# frozen_string_literal: true
module OzonApi
  class ItemService

    BASE_PATH = 'ItemService'.freeze

    def initialize(client)
      @client = client
    end

    def item_get(id)
      @client.get([BASE_PATH, 'ItemGet'].join('/'), 'ItemId': id )
    end

  end
end
