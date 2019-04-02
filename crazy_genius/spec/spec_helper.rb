# frozen_string_literal: true

require 'rspec'
require 'rack/test'
ENV['RACK_ENV'] = 'test'
require_relative '../config/app_init'

Dir["#{Crazy.path}/spec/helpers/**/*.rb"].sort.each(&method(:require))

Dir["#{Crazy.path}/spec/shared/**/*.rb"].sort.each(&method(:require))

Dir["#{Crazy.path}/spec/support/**/*.rb"].sort.each(&method(:require))

RSpec.configure do |config|
  config.expose_dsl_globally = false
  config.include Rack::Test::Methods
  path = File.join(File.dirname(__FILE__), 'factories')
  FactoryBot.definition_file_paths << path
  FactoryBot.find_definitions
end
