# frozen_string_literal: true
require 'active_model'

module OzonApi
  class Configuration
    include ActiveModel::Validations

    def self.attribute_names
      [:scheme, :host, :base_path, :login, :password, :out]
    end

    def attribute_names
      self.class.attribute_names
    end

    attr_accessor *attribute_names

    validates :scheme, :host, :base_path, :login, :password, presence: true

    def initialize
      @base_path = 'PartnerService'
      @scheme = 'https'
      @host = 'ows.ozon.ru'
      @login = ENV['OZON_LOGIN']
      @password = ENV['OZON_PASSWORD']
      @out = STDOUT

      yield(self) if block_given?

      [
        @base_path,
        @scheme,
        @host,
        @login,
        @password
      ].each(&:freeze)
    end
  end
end
