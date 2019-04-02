# frozen_string_literal: true

require 'set'
require 'singleton'

require_relative 'settings/configurable'

module Crazy
  # Класс, используемый для логгирования
  class Init
    extend  Settings::Configurable
    include Singleton

    settings_names :logger
  end
end
