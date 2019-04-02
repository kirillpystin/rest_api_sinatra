# frozen_string_literal: true

module Crazy
  module Actions
    # Добавление поддерживаемых действий для записей об ученых
    module Geniuses
      require_relative '../actions/base/action'
      require_relative 'geniuses/create'

      # Создание новой записи об ученом
      # и возварщение ассоциативного
      # массива с информацией о ней
      # @param [Object] params
      #  объект параметров действия, которые могут
      # быть как ассоциативным массивом,
      # json-строкой или объектом,
      # который поддерживает метод `read`
      # @param [NilClass, Hash] rest
      # ассоциативный массив дополнительных параметров
      # или `nil`, если доп.параметры отутствуют
      # @return [Hash]
      #   получение ассоциативного массив
      def self.create(params, rest = nil)
        Create.new(params, rest).create
      end

      require_relative 'geniuses/destroy'

      # Удаление записи об ученом
      # @param [Object] params
      #   объект параметров действия,
      # которые могут быть как ассоциативным массивом,
      # json-строкой или объектом, который поддерживает метод `read`
      # @param [NilClass, Hash] rest
      # ассоциативный массив дополнительных параметров
      # или `nil`, если доп.параметры отутствуют
      # удаление записи
      def self.destroy(params, rest = nil)
        Destroy.new(params, rest).destroy
      end

      require_relative 'geniuses/index'

      # Извлечение и вывод массива с информацией об ученых
      # @param [Object] params
      #  объект параметров действия,
      # которые могут быть как ассоциативным массивом,
      # json-строкой или объектом, который поддерживает метод `read`
      # @return [Array]
      # @param [NilClass, Hash] rest
      # ассоциативный массив дополнительных параметров
      # или `nil`, если доп.параметры отутствуют
      #   получение массива
      def self.index(params, rest = nil)
        Index.new(params, rest).index
      end

      require_relative 'geniuses/show'

      # Извлечение и вывод массива с информацией об ученом
      # @param [Object] params
      #  объект параметров действия,
      # которые могут быть как ассоциативным массивом,
      # json-строкой или объектом, который поддерживает метод `read`
      # @param [NilClass, Hash] rest
      # ассоциативный массив дополнительных параметров
      # или `nil`, если доп.параметры отутствуют
      # @return [Array]
      #   получение массива
      def self.show(params, rest = nil)
        Show.new(params, rest).show
      end

      require_relative 'geniuses/update'

      # Обновление информации об ученом
      # @param [Object] params
      #   объект параметров действия,
      # которые могут быть как ассоциативным массивом,
      # json-строкой или объектом, который поддерживает метод `read`
      # @param [NilClass, Hash] rest
      # ассоциативный массив дополнительных параметров
      # или `nil`, если доп.параметры отутствуют
      def self.update(params, rest = nil)
        Update.new(params, rest).update
      end
    end
  end
end
