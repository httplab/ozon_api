# frozen_string_literal: true
module OzonApi
  class ItemService

    def initialize(client)
      @client = client
    end

    def item_get(item_id)
      @client.get([base_path, 'ItemGet'].join('/'), 'ItemId': item_id )
    end

    private

    def base_path
      @base_path ||= 'ItemService'.freeze
    end

  end
end
