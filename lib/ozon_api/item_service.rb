# frozen_string_literal: true
module OzonApi
  class ItemService
    BASE_PATH = 'ItemService'

    def initialize(client)
      @client = client
    end

    def item_availabilities_get
      @client.get([BASE_PATH, 'ItemAvailabilitiesGet'].join('/'))
    end

    def item_get(id)
      @client.get([BASE_PATH, 'ItemGet'].join('/'), 'ItemId': id)
    end

    def items_by_id_list_get(item_ids:, items_on_page: 50, page_number:, only_for_sale:, partner_client_id:)
      @client.get(
        [BASE_PATH, 'ItemsByIdListGet'].join('/'),
        'items': item_ids.join(','),
        'itemsOnPage': items_on_page,
        'pageNumber': page_number,
        'onlyForSale': only_for_sale,
        'partnerClientId': partner_client_id
      )
    end
  end
end
