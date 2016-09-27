# frozen_string_literal: true
module OzonApi
  class CartService
    BASE_PATH = 'CartService'

    def initialize(client)
      @client = client
    end

    def cart_get(partner_client_id:)
      @client.get([BASE_PATH, 'CartGet'].join('/'), 'partnerClientId': partner_client_id)
    end

    def cart_add(partner_client_id:, cart_items:, partner_agent_id: nil, delay_cart_update: false)
      params = {
        'partnerClientId': partner_client_id,
        'cartItems': Array(cart_items).map { |i| "#{i[:partner_id]}:#{i[:quantity]}" }.join(','),
        'partnerAgentId': partner_agent_id,
        'delayCartUpdate': delay_cart_update
      }

      @client.post([BASE_PATH, 'CartAdd'].join('/'), params)
    end

    def cart_remove(partner_client_id:, cart_item_ids:)
      params = {
        'partnerClientId': partner_client_id,
        'cartItems': Array(cart_item_ids).map(&:to_s).join(',')
      }

      @client.post([BASE_PATH, 'CartRemove'].join('/'), params)
    end
  end
end
