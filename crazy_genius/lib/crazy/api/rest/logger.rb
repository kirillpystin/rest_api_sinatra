# frozen_string_literal: true

require 'rack/common_logger'

module Crazy
  module API
    module REST
      # класс Rack-логгера
      class Logger < Rack::CommonLogger
        # инициализация
        # @param [#call] app
        #   Rack-приложение
        def initialize(app)
          super(app, Crazy.logger)
        end

        # Массив имен методов с отклчюенной регистрацией в Rack-logging
        BLACK_LIST = %w[/version].freeze

        # Принимает вызов от Rack
        # @param [Hash] env
        #   ассоциативный массив Rack-параметров
        def call(env)
          black_listed?(env) ? @app.call(env) : super
        end

        # Возвращает, если  Rack-logging был отключен для REST API метода
        # @param [Hash] env
        #   ассоциативный массив Rack-параметров
        # @return [Boolean]
        #   если Rack-logging был отключен для REST API метода
        def black_listed?(env)
          BLACK_LIST.include?(env['PATH_INFO'])
        end
      end
    end
  end
end
