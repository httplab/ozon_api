# frozen_string_literal: true
module OzonApi
  class CheckoutService
    BASE_PATH = 'CheckoutService'

    def initialize(client)
      @client = client
    end

    def checkout_start(partner_client_id:, is_pred_release: false)
      @client.get(
        [BASE_PATH, 'CheckoutStart'].join('/'),
        'partnerClientId': partner_client_id,
        'isPredRelease': is_pred_release
      )
    end

    def checkout_favourites_get(partner_client_id:, order_guid:)
      @client.get(
        [BASE_PATH, 'CheckoutFavouritesGet'].join('/'),
        'partnerClientId': partner_client_id,
        'guidValue': order_guid
      )
    end

    def delivery_addresses_get(partner_client_id:, order_guid:)
      @client.get(
        [BASE_PATH, 'DeliveryAddressesGet'].join('/'),
        'partnerClientId': partner_client_id,
        'guidValue': order_guid
      )
    end

    def delivery_variants_get(partner_client_id:, order_guid:, area_id:, address_id: 0)
      @client.get(
        [BASE_PATH, 'DeliveryVariantsGet'].join('/'),
        'partnerClientId': partner_client_id,
        'guidValue': order_guid,
        'areaId': area_id,
        'addressId': address_id
      )
    end

    def payments_variants_get(partner_client_id:,
                              order_guid:,
                              area_id:,
                              address_id: 0,
                              delivery_variant_id:)
      @client.get(
        [BASE_PATH, 'PaymentsVariantsGet'].join('/'),
        'partnerClientId': partner_client_id,
        'guidValue': order_guid,
        'areaId': area_id,
        'addressId': address_id,
        'deliveryVariantId': delivery_variant_id
      )
    end

    def order_parameters_get_for_collect(partner_client_id:,
                                         order_guid:,
                                         area_id:,
                                         address_id: 0,
                                         delivery_variant_id:,
                                         payment_type_id:,
                                         zip_code: nil)
      @client.get(
        [BASE_PATH, 'OrderParametersGetForCollect'].join('/'),
        'partnerClientId': partner_client_id,
        'guidValue': order_guid,
        'areaId': area_id,
        'addressId': address_id,
        'deliveryVariantId': delivery_variant_id,
        'paymentTypeId': payment_type_id,
        'zipCode': zip_code
      )
    end

    def order_parameters_save(partner_client_id:,
                              order_guid:,
                              area_id:,
                              address_id: 0,
                              delivery_variant_id:,
                              payment_type_id:,
                              zip_code:,
                              country:,
                              region:,
                              district: nil,
                              city:,
                              address_tail: nil,
                              comment: nil,
                              phone:,
                              metro_id: 0,
                              first_name:,
                              middle_name: nil,
                              last_name:,
                              street: nil,
                              house: nil,
                              entrance: nil,
                              apartment: nil,
                              intercom: nil,
                              floor: nil)
      params = {
        'partnerClientId': partner_client_id,
        'guidValue': order_guid,
        'areaId': area_id,
        'addressId': address_id,
        'deliveryVariantId': delivery_variant_id,
        'paymentTypeId': payment_type_id,
        'zipCode': zip_code,
        'country': country,
        'region': region,
        'district': district,
        'city': city,
        'addressTail': address_tail,
        'comment': comment,
        'phone': phone,
        'metroId': metro_id,
        'firstName': first_name,
        'middleName': middle_name,
        'lastName': last_name,
        'street': street,
        'house': house,
        'entrance': entrance,
        'apartment': apartment,
        'intercom': intercom,
        'floor': floor
      }
      params.delete_if { |_, v| v.nil? }
      @client.post([BASE_PATH, 'OrderParametersSave'].join('/'), params)
    end

    def delivery_choices_get
      @client.get([BASE_PATH, 'DeliveryChoicesGet'].join('/'))
    end

    def order_parameters_check(partner_client_id:,
                               order_guid:,
                               address_id:,
                               delivery_variant_id:,
                               payment_type_id:,
                               delivery_choice_id:,
                               client_account_sum:,
                               is_pred_release: false)
      @client.get(
        [BASE_PATH, 'OrderParametersCheck'].join('/'),
        'partnerClientId': partner_client_id,
        'guidValue': order_guid,
        'addressId': address_id,
        'deliveryVariantId': delivery_variant_id,
        'paymentTypeId': payment_type_id,
        'deliveryChoiceId': delivery_choice_id,
        'clientAccountSum': client_account_sum,
        'isPredRelease': is_pred_release
      )
    end

    def order_summary_get(partner_client_id:,
                          order_guid:,
                          address_id:,
                          delivery_variant_id:,
                          payment_type_id:,
                          delivery_choice_id:,
                          client_account_sum:,
                          user_score:)
      @client.get(
        [BASE_PATH, 'OrderSummaryGet'].join('/'),
        'partnerClientId': partner_client_id,
        'guidValue': order_guid,
        'addressId': address_id,
        'deliveryVariantId': delivery_variant_id,
        'paymentTypeId': payment_type_id,
        'deliveryChoiceId': delivery_choice_id,
        'clientAccountSum': client_account_sum,
        'userScore': user_score
      )
    end

    def order_create(partner_client_id:,
                     order_guid:,
                     address_id:,
                     delivery_variant_id:,
                     delivery_choice_id:,
                     payment_type_id:,
                     is_pred_release: false,
                     client_account_sum:,
                     email:,
                     phone:,
                     first_name:,
                     middle_name: nil,
                     last_name:,
                     comment: nil,
                     use_score:,
                     metro_id: 0)
      params = {
        'partnerClientId': partner_client_id,
        'guidValue': order_guid,
        'addressId': address_id,
        'deliveryVariantId': delivery_variant_id,
        'deliveryChoiceId': delivery_choice_id,
        'paymentTypeId': payment_type_id,
        'isPredRelease': is_pred_release,
        'clientAccountSum': client_account_sum,
        'email': email,
        'phone': phone,
        'firstName': first_name,
        'middleName': middle_name,
        'lastName': last_name,
        'comment': comment,
        'useScore': use_score,
        'metroId': metro_id
      }
      params.delete_if { |_, v| v.nil? }
      @client.post([BASE_PATH, 'OrderCreate'].join('/'), params)
    end
  end
end
