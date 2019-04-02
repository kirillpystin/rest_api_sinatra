# frozen_string_literal: true

module Crazy
  module Actions
    module Invents
      # Класс для вывода информации об изобретении
      class Show < Base::Action
        require_relative 'show/params_schema'

        # Запрос, извлекающий поле `created_at` из 'invents'
        CREATED_AT =
          :to_char
          .sql_function(:created_at, 'YYYY-mm-dd HH:MM:SS')
          .as(:created_at)

        # Массив значений для извлечения полей из таблицы 'invents'
        COLUMNS = [:id, :name, :power, CREATED_AT].freeze

        # Набор данныз из  таблицы `invents`
        DATASET = Models::Invent.select(*COLUMNS).naked

        # Извлекает набор данных по 'id'
        # @return [Hash]
        # получение ассоциативного массива
        def show
          DATASET.with_pk!(id)
        end

        private

        # Получение `id`
        def id
          params[:id]
        end
      end
    end
  end
end
