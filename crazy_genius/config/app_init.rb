# frozen_string_literal: true

require 'dotenv'
require 'erb'
require 'yaml'
require_relative '../lib/crazy'

# загрузка переменной окружения
Dotenv.load(File.absolute_path("#{Crazy.path}/.env.#{ENV['RACK_ENV']}"))

Dir["#{Crazy.path}/config/initializers/**/*.rb"].sort.each(&method(:require))
