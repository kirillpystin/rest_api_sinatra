# frozen_string_literal: true

require 'logger'

require_relative 'log/prefix'

module Crazy
  # Модуль, отвчающий за вспомогательные методы
  module Helpers
    # Добавление методов для ведения журнала исключений
    module Log
      private

      # Возвращает журнал
      # @return [Logger]
      def logger
        Crazy.logger
      end

      # Выдает сообщение
      # и регистрирует его с указанным уровнем и контекстом журнала.
      # @param [Integer] level
      #   Уровень журнала
      # @param [Binding] context
      #   контекст
      # @yield [String]
      #   сообщение
      def log_with_level(level, context = nil)
        return unless logger.is_a?(Logger)

        logger.log(level) do
          prefix = Prefix.new(context).prefix
          message = adjusted_message(yield)
          [prefix, message].find_all(&:present?).join(' ')
        end

        nil
      end

      # Выдает сообщение и регистрирует
      # его с уровнем журнала DEBUG и предоставленным контекстом.
      # @param [Binding] context
      #   контекст
      # @yield [String]
      #   сообщение
      def log_debug(context = nil, &block)
        log_with_level(Logger::DEBUG, context, &block)
      end

      # Выдает сообщение и регистрирует
      # его с уровнем журнала INFO и предоставленным контекстом
      # @param [Binding] context
      #   контекст
      # @yield [String]
      #   сообщение
      def log_info(context = nil, &block)
        log_with_level(Logger::INFO, context, &block)
      end

      # Выдает сообщение и регистрирует
      # его с уровнем журнала WARN и предоставленным контекстом.
      # @param [Binding] context
      #   контекст
      # @yield [String]
      #   сообщение
      def log_warn(context = nil, &block)
        log_with_level(Logger::WARN, context, &block)
      end

      #  Выдает сообщение и регистрирует
      # его с уровнем журнала ERROR и предоставленным контекстом
      # @param [Binding] context
      #   контекст
      # @yield [String]
      #   сообщение
      def log_error(context = nil, &block)
        log_with_level(Logger::ERROR, context, &block)
      end

      # Выдает сообщение и регистрирует его
      # с уровнем журнала UNKNOWN и предоставленным контекстом
      # @param [Binding] context
      #   контекст
      # @yield [String]
      #   сообщение
      def log_unknown(context = nil, &block)
        log_with_level(Logger::UNKNOWN, context, &block)
      end

      # Возвращает правильную строку в кодировке UTF-8 из аргумента
      # @param [#to_s] obj
      #   аргумент
      # @return [String]
      #   получение строки
      def repaired_string(obj)
        str = obj.to_s
        return str if str.encoding == Encoding::UTF_8 && str.valid_encoding?

        str = str.dup if str.frozen?
        str.force_encoding(Encoding::UTF_8)
        return str if str.valid_encoding?

        str.force_encoding(Encoding::ASCII_8BIT)
        str.encode(Encoding::UTF_8, undef: :replace, invalid: :replace)
      end

      # Возвращает правильную строку в кодировке UTF-8 из аргумента с
      # сжиманием пустых символов
      # @param [#to_s] message
      #   аргумент
      # @return [String]
      #   получение строки
      def adjusted_message(message)
        repaired_string(message).squish
      end
    end
  end
end
