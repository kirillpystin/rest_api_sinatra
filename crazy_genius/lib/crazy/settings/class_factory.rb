# frozen_string_literal: true

require_relative 'mixin'

module Crazy
  module Settings
    # Предоставляет функцию для создания классов настроек
    module ClassFactory
      # Создает новый класс настроек с предоставленными именами и возвращает его
      # @param [Array<#to_s>] names
      #   массив имен настроек
      # @return [Class]
      #   класс настроек
      def self.create(*names)
        names.map! { |name| name.is_a?(Symbol) ? name : name.to_s.to_sym }
        Struct.new(*names) { include Mixin }
      end
    end
  end
end
