# frozen_string_literal: true
module OzonApi
  class OrderService
    BASE_PATH = 'OrderService'

    def initialize(client)
      @client = client
    end

    def orders_get(partner_client_id:)
      @client.get(
        [BASE_PATH, 'OrdersGet'].join('/'), 'partnerClientId': partner_client_id
      )
    end

    def order_get(partner_client_id:, order_number:)
      @client.get(
        [BASE_PATH, 'OrderGet'].join('/'),
        'partnerClientId': partner_client_id,
        'orderNumber': order_number
      )
    end

    def cancel_reasons_get
      @client.get([BASE_PATH, 'CancelReasonsGet'].join('/'))
    end

    def order_cancel(partner_client_id:,
                     order_number:,
                     items:,
                     reason_id:)
      @client.post(
        [BASE_PATH, 'OrderCancel'].join('/'),
        'partnerClientId': partner_client_id,
        'orderNumber': order_number,
        'itemString': Array(items).map { |i| "#{i[:partner_id]}:#{i[:quantity]}" }.join(','),
        'reasonId': reason_id
      )
    end

    def posting_cancel(partner_client_id:,
                       order_number:,
                       posting_id:,
                       reason_id:)
      @client.post(
        [BASE_PATH, 'PostingCancel'].join('/'),
        'partnerClientId': partner_client_id,
        'orderNumber': order_number,
        'postingId': posting_id,
        'reasonId': reason_id
      )
    end
  end
end
