# frozen_string_literal: true

module Crazy
  # Модуль, отвеающий за установку настроек
  module Settings
    # Предоствляет метод,
    # для установки собственных значений настроек
    module Mixin
      # Устанавливает значения для настроек
      # @param [#to_s] setting
      #   name of the setting
      # @param [Object] value
      #   value of the setting
      def set(setting, value)
        send("#{setting}=", value)
      end

      # Устанавливает значение настроек `true`
      # @param [#to_s] setting
      #   название настроек
      def enable(setting)
        set(setting, true)
      end

      # Устанавливает значение настроек `false`
      # @param [#to_s] setting
      #   название настроек
      def disable(setting)
        set(setting, false)
      end
    end
  end
end
