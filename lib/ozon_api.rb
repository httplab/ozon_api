# frozen_string_literal: true
module OzonApi
  require 'ozon_api/configuration'
  require 'ozon_api/client'
  require 'ozon_api/item_service'
  require 'ozon_api/detail_service'
  require 'ozon_api/client_service'
  require 'ozon_api/cart_service'
  require 'ozon_api/checkout_service'
  require 'ozon_api/order_service'
  require 'ozon_api/address_service'

  InvalidConfigurationError = Class.new(StandardError)

  def self.setup(&blk)
    @config ||= OzonApi::Configuration.new(&blk)

    if @config.invalid?
      msg = "OzonApi configuration ERROR:\n"
      raise InvalidConfigurationError, msg + @config.errors.full_messages.join("\n")
    end

    @config
  end

  def self.reset
    @config = nil
  end

  class << self
    extend Forwardable

    def_delegators :item_service, :item_availabilities_get, :item_get, :items_by_id_list_get
    def_delegator :detail_service, :detail_get
    def_delegators :client_service, :client_check_email, :client_registration, :client_login
    def_delegators :cart_service, :cart_get, :cart_add, :cart_remove
    def_delegators(
      :checkout_service,
      :checkout_start,
      :checkout_favourites_get,
      :delivery_addresses_get,
      :delivery_variants_get,
      :payments_variants_get,
      :order_parameters_get_for_collect,
      :order_parameters_save,
      :delivery_choices_get,
      :order_parameters_check,
      :order_summary_get,
      :order_create
    )
    def_delegators(
      :order_service,
      :orders_get,
      :order_get,
      :cancel_reasons_get,
      :order_cancel,
      :posting_cancel
    )
    def_delegators :address_service, :search_cities, :get_cities, :search_streets
  end

  private

  def self.client
    @client ||= OzonApi::Client.new(@config)
  end

  def self.item_service
    @item_service ||= OzonApi::ItemService.new(client)
  end

  def self.detail_service
    @detail_service ||= OzonApi::DetailService.new(client)
  end

  def self.client_service
    @client_service ||= OzonApi::ClientService.new(client)
  end

  def self.cart_service
    @cart_service ||= OzonApi::CartService.new(client)
  end

  def self.checkout_service
    @checkout_service ||= OzonApi::CheckoutService.new(client)
  end

  def self.order_service
    @order_service ||= OzonApi::OrderService.new(client)
  end

  def self.address_service
    @address_service ||= OzonApi::AddressService.new(client)
  end
end
