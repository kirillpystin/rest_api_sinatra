# frozen_string_literal: true

require 'json-schema'

module Crazy
  require_relative "#{Crazy.path}/lib/crazy/helpers/log"

  # Модуль, отвечающий за API
  module API
    # Модуль, отвечающий за обработку REST API
    module REST
      # Модуль, добавляющий обработку ошибок
      module Errors
        # Модуль, предоставляющий вспомогательные методы
        module Helpers
          include Crazy::Helpers::Log

          # Вывод информации об исключении
          # @return [Exception]
          #  объект с информацией об исключении
          def error
            env['sinatra.error']
          end

          # Намиенование сервиса в верхнем регистре
          NAME = Crazy.name.upcase.freeze

          # Логгирование
          def log_regular_error
            log_error { <<~LOG }
              #{NAME} ERROR #{error.class} WITH MESSAGE #{error.message}
            LOG
          end
        end

        # Сопоставление классов исключений с HTTP-кодами
        ERRORS_MAP = {
          ArgumentError => 422,
          JSON::Schema::ValidationError => 422,
          Oj::ParseError => 422,
          RuntimeError => 422,
          Sequel::DatabaseError => 422,
          Sequel::Error => 422,
          Sequel::NoMatchingRow => 404,
          Sequel::InvalidValue => 422,
          Sequel::UniqueConstraintViolation => 422
        }.freeze

        # Регистрация обработчика исключений
        # @param [Crazy::API::REST::Controller] controller
        #   REST API контроллер
        # @param [Class] error_class
        #   класс исключения
        # @param [Integer] error_code
        #   HTTP код
        def self.define_error_handler(controller, error_class, error_code)
          controller.error error_class do
            log_regular_error unless error_code == 404
            status error_code
            content = { error: error_class, message: error.message }
            body Oj.dump(content)
          end
        end

        # Регистрирует обработчки исключений в соответствии с {ERRORS_MAP}
        # @param [Crazy::API::REST::Controller] controller
        #   REST API контроллер
        def self.define_error_handlers(controller)
          ERRORS_MAP.each do |error_class, error_code|
            define_error_handler(controller, error_class, error_code)
          end
        end

        # Обработка исключений не соответствующих
        # {ERRORS_MAP}
        # @param [Crazy::API::REST::Controller] controller
        #  REST API контроллер
        def self.define_500_handler(controller)
          controller.error 500 do
            log_regular_error
            status 500
            content = { error: error.class, message: error.message }
            body Oj.dump(content)
          end
        end

        # Регистрация обработчиков исключений
        # @param [Crazy::API::REST::Controller] controller
        #   REST API контроллер
        def self.registered(controller)
          controller.helpers Helpers
          define_error_handlers(controller)
          define_500_handler(controller)
        end
      end

      Controller.register Errors
    end
  end
end
