# frozen_string_literal: true

require_relative 'class_factory'

module Crazy
  module Settings
    # Добавление настроек приложеня
    module Configurable
      # Возварщение настроек
      # @return [Settings]
      #   настройки
      def settings
        @settings ||= settings_class.new
      end

      # Настройки блоков
      # @yieldparam [Settings]
      #   настрйки
      def configure
        yield settings
      end

      private

      # Добавление аргументов в массив имен настроек и возвращение массива
      # @param [Array] args
      #   массив имен настроек
      # @return [Array]
      #   массив имен настроек
      def settings_names(*args)
        @settings_names ||= []
        @settings_names.concat(args)
      end

      # Возвращение класса настроек
      # @return [Class]
      #   класс настроек
      def settings_class
        @settings_class ||= ClassFactory.create(*settings_names)
      end
    end
  end
end
