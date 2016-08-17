# frozen_string_literal: true
require 'net/http'
require 'uri'
require 'json'

module OzonApi
  class Client
    InvalidConfigurationError = Class.new(StandardError)

    CONFIGURATION_KEYS = [:scheme, :host, :base_path, :login, :password, :partner_client_id, :out].freeze

    def initialize(hsh = {})
      @config = hsh.select do |key, _|
        CONFIGURATION_KEYS.include? key.to_sym
      end
    end

    def get(path, params)
      uri = URI("#{scheme}://#{host}/#{base_path}/#{path}/")
      params.merge!(default_params)
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get(uri)
      if out
        out << "Ozon get:\n"
        out << uri.to_s
        out << "Ozon response:\n"
        out << response
        out << "\n"
      end
      JSON.parse(response)
    end

    private

    def default_params
      @default_params ||= {
        login: login,
        password: password,
        partnerClientId: partner_client_id
      }.freeze
    end

    def base_path
      @base_path ||= @config[:base_path] || 'PartnerService'
    end

    def scheme
      @scheme ||= @config[:scheme] || 'https'
    end

    def host
      @host ||= @config[:host] || 'ows.ozon.ru'
    end

    def login
      return @login if @login
      @login = @config[:login] || ENV['OZON_LOGIN']
      raise InvalidConfigurationError, 'Missing OZON_LOGIN' if @login.nil?
      @login
    end

    def password
      return @password if @password
      @password = @config[:password] || ENV['OZON_PASSWORD']
      raise InvalidConfigurationError, 'Missing OZON_PASSWORD' if @password.nil?
      @password
    end

    def partner_client_id
      @partner_client_id = @config[:partner_client_id] || ENV['OZON_PARTNER_CLIENT_ID']
      raise InvalidConfigurationError, 'Missing OZON_PARTNER_CLIENT_ID' if @partner_client_id.nil?
      @partner_client_id
    end

    def out
      @config[:out]
    end
  end
end
