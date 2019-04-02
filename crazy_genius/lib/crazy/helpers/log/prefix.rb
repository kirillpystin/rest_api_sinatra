# frozen_string_literal: true

module Crazy
  module Helpers
    module Log
      # Класс объектов, которые формирую префиксы к сообщениям журнала
      class Prefix
        # Контекст
        # @return [Binding]
        #   контекст
        attr_reader :context

        # Создание экземпляра
        # @param [Binding] context
        #   контекст
        def initialize(context)
          @context = context
        end

        # Возвращает строку с префиксом сообщения журнала,
        # образованную тегами, возвращаемыми
        # {eval_strings} и дополнительные теги
        # @param [Array<#to_s>] tags
        #   массив дополнительных тегов
        # @return [String]
        #   строка с префиксом
        def prefix(*tags)
          tags
            .concat(eval_strings)
            .find_all(&:present?)
            .map { |tag| "[#{tag}]" }
            .join(' ')
        end

        private

        # Массив выражений, которые оцениваются в заданном контексте
        EVAL_STRINGS = ['self.class', '__method__', '__LINE__'].freeze

        # Возвращение массива извлеченных тегов из передоваемого контекста
        # @return [Array]
        #   массив тэгов
        def eval_strings
          return [] unless context.is_a?(Binding)

          EVAL_STRINGS.map(&context.method(:eval))
        end
      end
    end
  end
end
