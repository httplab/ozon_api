# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'ozon_api/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ozon_api'
  s.version     = OzonApi::VERSION
  s.authors     = ['Yury Kotov']
  s.email       = ['non.gi.suong@ya.ru']
  s.homepage    = 'https://github.com/httplab/ozon_api'
  s.summary     = 'Ruby Ozon API wrapper.'
  s.description = 'Ruby Ozon API wrapper.'
  s.license     = 'MIT'

  s.files = Dir['{lib}/**/*', 'LICENSE', 'README.md']

  s.add_dependency 'activemodel'
end
