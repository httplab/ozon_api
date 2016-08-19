# frozen_string_literal: true

require 'webmock/rspec'
require 'vcr'
require 'approvals/rspec'
require 'simplecov'
SimpleCov.minimum_coverage 100
SimpleCov.start

if ENV['TRAVIS_CI']
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

Approvals.configure do |c|
  c.excluded_json_keys = { datetime: 'DateTime' }
end

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<OZON_LOGIN>') { ENV['OZON_LOGIN'] }
  c.filter_sensitive_data('<OZON_PASSWORD>') { ENV['OZON_PASSWORD'] }
  c.filter_sensitive_data('<OZON_PARTNER_CLIENT_ID>') { "partnerClientId=#{ENV['OZON_PARTNER_CLIENT_ID']}" }
end

require 'ozon_api'

RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end
end
