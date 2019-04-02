# frozen_string_literal: true

require "#{Crazy.rest_dir}/controller"

Dir["#{Crazy.rest_dir}/geniuses/*.rb"].each(&method(:require))
Dir["#{Crazy.rest_dir}/invents/*.rb"].each(&method(:require))

require "#{Crazy.rest_dir}/logger"
require "#{Crazy.rest_dir}/errors"

Crazy::API::REST::Controller.configure do |settings|
  settings.set :bind, ENV['BIND']
  settings.set :port, ENV['PORT']

  settings.disable :show_exceptions
  settings.disable :dump_errors
  settings.enable  :raise_errors

  settings.use Crazy::API::REST::Logger

  settings.enable :static
end

Crazy::API::REST::Controller.configure :production do |settings|
  settings.set :server, :puma
end
