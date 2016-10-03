# frozen_string_literal: true
require 'spec_helper'
require 'shared_contexts/having_configured_client'

describe OzonApi::CheckoutService do
  include_context 'having configured client'

  let(:partner_client_id) { 'hb1' }

  let(:vcr_options) do
    ['checkout_service', { record: :once, match_requests_on: [:method, :uri] }]
  end

  let(:order_guid) do
    subject.checkout_start(partner_client_id: partner_client_id)['OrderGuid']
  end

  describe '#checkout_start' do
    it 'returns order GUID' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) { subject.checkout_start(partner_client_id: partner_client_id) }
      end
    end
  end

  describe '#checkout_favourites_get' do
    it 'returns a list of favourite items' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.checkout_favourites_get(
            partner_client_id: partner_client_id,
            order_guid: order_guid
          )
        end
      end
    end
  end

  describe '#delivery_addresses_get' do
    it 'returns a list of saved addresses and a list of regions' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.delivery_addresses_get(
            partner_client_id: partner_client_id,
            order_guid: order_guid
          )
        end
      end
    end
  end

  describe '#delivery_variants_get' do
    let(:area_id) { 9796 }

    it 'returns a list of delivery variants' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.delivery_variants_get(
            partner_client_id: partner_client_id,
            order_guid: order_guid,
            area_id: area_id
          )
        end
      end
    end
  end

  describe '#payments_variants_get' do
    let(:area_id) { 9796 }
    let(:address_id) { 0 }
    let(:delivery_variant_id) { 488 }

    it 'returns a list of payments variants' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.payments_variants_get(
            partner_client_id: partner_client_id,
            order_guid: order_guid,
            area_id: area_id,
            address_id: address_id,
            delivery_variant_id: delivery_variant_id
          )
        end
      end
    end
  end

  describe '#order_parameters_get_for_collect' do
    let(:area_id) { 9796 }
    let(:address_id) { 0 }
    let(:delivery_variant_id) { 488 }
    let(:payment_type_id) { 60 }

    it 'returns a list of parameters to fill' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.order_parameters_get_for_collect(
            partner_client_id: partner_client_id,
            order_guid: order_guid,
            area_id: area_id,
            address_id: address_id,
            delivery_variant_id: delivery_variant_id,
            payment_type_id: payment_type_id
          )
        end
      end
    end
  end

  describe '#delivery_choices_get' do
    it 'returns a list of delivery choices' do
      VCR.use_cassette(*vcr_options) do
        verify(format: :json) do
          subject.delivery_choices_get
        end
      end
    end
  end

  context 'given order parameters' do
    let(:area_id) { 9796 }
    let(:address_id) { 0 }
    let(:new_address_id) { subject.order_parameters_save(order_parameters)['NewAddressId'] }
    let(:delivery_variant_id) { 488 }
    let(:payment_type_id) { 60 }
    let(:country) { 'Россия' }
    let(:zip_code) { '344000' }
    let(:region) { 'Ростовская область' }
    let(:city) { 'Ростов-На-Дону' }
    let(:street) { 'Буденновский проспект' }
    let(:house) { '35' }
    let(:apartment) { '12' }
    let(:entrance) { '9' }
    let(:intercom) { '000' }
    let(:floor) { '1' }
    let(:phone) { '9090000000' }
    let(:first_name) { 'Test' }
    let(:last_name) { 'Test' }
    let(:order_parameters) do
      {
        partner_client_id: partner_client_id,
        order_guid: order_guid,
        area_id: area_id,
        address_id: address_id,
        delivery_variant_id: delivery_variant_id,
        payment_type_id: payment_type_id,
        country: country,
        zip_code: zip_code,
        region: region,
        city: city,
        street: street,
        house: house,
        apartment: apartment,
        entrance: entrance,
        intercom: intercom,
        floor: floor,
        phone: phone,
        first_name: first_name,
        last_name: last_name
      }
    end
    let(:delivery_choice_id) { 1 }
    let(:use_score) { true }
    let(:client_account_sum) { 0 }
    let(:email) { 'user@httplab.ru' }

    describe '#order_parameters_save' do
      it 'returns an ID of address' do
        VCR.use_cassette(*vcr_options) do
          verify(format: :json) do
            subject.order_parameters_save(order_parameters)
          end
        end
      end
    end

    describe '#order_parameters_check' do
      it 'returns a status' do
        VCR.use_cassette(*vcr_options) do
          verify(format: :json) do
            subject.order_parameters_check(
              partner_client_id: partner_client_id,
              order_guid: order_guid,
              address_id: new_address_id,
              delivery_variant_id: delivery_variant_id,
              payment_type_id: payment_type_id,
              delivery_choice_id: delivery_choice_id,
              client_account_sum: client_account_sum
            )
          end
        end
      end
    end

    describe '#order_summary_get' do
      it 'returns a status' do
        VCR.use_cassette(*vcr_options) do
          verify(format: :json) do
            subject.order_summary_get(
              partner_client_id: partner_client_id,
              order_guid: order_guid,
              address_id: new_address_id,
              delivery_variant_id: delivery_variant_id,
              payment_type_id: payment_type_id,
              delivery_choice_id: delivery_choice_id,
              client_account_sum: client_account_sum,
              user_score: use_score
            )
          end
        end
      end
    end

    describe '#order_create' do
      it 'returns an order number and an url' do
        VCR.use_cassette(*vcr_options) do
          verify(format: :json) do
            subject.order_create(
              partner_client_id: partner_client_id,
              order_guid: order_guid,
              address_id: new_address_id,
              delivery_variant_id: delivery_variant_id,
              payment_type_id: payment_type_id,
              delivery_choice_id: delivery_choice_id,
              client_account_sum: client_account_sum,
              email: email,
              phone: phone,
              first_name: first_name,
              last_name: last_name,
              use_score: use_score
            )
          end
        end
      end
    end
  end
end
