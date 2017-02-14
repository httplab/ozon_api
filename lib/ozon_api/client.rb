# frozen_string_literal: true
require 'net/http'
require 'uri'
require 'json'

module OzonApi
  class Client
    ApiError = Class.new(StandardError)

    SUCCESS_STATUS = 2

    def initialize(configuration)
      @config = configuration
    end

    def get(path, params = {})
      uri = URI("#{scheme}://#{host}/#{base_path}/#{path}/")
      uri.query = URI.encode_www_form(default_params.merge(params))
      response = Net::HTTP.get(uri)

      if out
        out << "Ozon get:\n"
        out << uri.to_s
        out << "\n"
        out << "Ozon plain response:\n"
        out << response
        out << "\n"
      end

      parse_response(response)
    end

    def post(path, params)
      query = URI.encode_www_form(default_params.merge(params))
      uri   = URI("#{scheme}://#{host}/#{base_path}/#{path}/?#{query}")

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(uri)
      response = http.request(request)

      if out
        out << "Ozon post:\n"
        out << uri.to_s
        out << "\n"
        out << "Ozon response:\n"
        out << response
        out << "\n"
      end

      parse_response(response.read_body)
    end

    private

    def default_params
      @default_params ||= {
        login: login,
        password: password
      }.freeze
    end

    def base_path
      @config.base_path
    end

    def scheme
      @config.scheme
    end

    def host
      @config.host
    end

    def login
      @config.login
    end

    def password
      @config.password
    end

    def out
      @config.out
    end

    def debug
      @config.debug
    end

    def parse_response(data)
      result = JSON.parse(data)
      if out && debug
        out << "Ozon response json:\n"
        out << result
        out << "\n"
      end

      if result['Status'] == SUCCESS_STATUS && result['Error'].nil?
        result
      else
        raise ApiError, data
      end
    end
  end
end
