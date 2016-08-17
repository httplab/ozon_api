# frozen_string_literal: true
require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'OzonApi'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'bundler/gem_tasks'

task :console do
  require 'pry'
  lib = File.expand_path('lib')
  $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
  require 'ozon_api'
  ARGV.clear
  Pry.start
end

task :release_tag do
  system "git commit -a -m 'Release #{OzonApi::VERSION}'"
  system "git tag -a v#{OzonApi::VERSION} -m 'version #{OzonApi::VERSION}'"
end

desc 'Push to Github'
task :push do
  system 'git push --tags origin master'
end

desc 'Build the gem'
task :build do
  system 'bundle exec gem build ozon_api.gemspec'
end

desc "Release version #{OzonApi::VERSION}"
task release: [:build, :release_tag, :push] do
  system "bundle exec gem push ozon_api-#{OzonApi::VERSION}.gem"
end
