# frozen_string_literal: true

module Crazy
  module Actions
    module Geniuses
      # Класс, который извлекает информацию об ученом
      class Show < Base::Action
        require_relative 'show/params_schema'

        # Sequel запрос, который используется для получение 'created'
        CREATED =
          :to_char
          .sql_function(:created, 'YYYY-mm-dd HH:MM:SS')
          .as(:created)

        # Массив для извлечения полей записи об ученом
        COLUMNS = [:id, :name, :crazy, :try_kill, CREATED].freeze

        # Набор данных, которые извлекаются из 'geniuses' при помощи `COLUMNS`
        DATASET = Models::Geniuses.select(*COLUMNS).naked

        # Извлекает набор данных по 'id'
        # @return [Hash]
        # получение ассоциативного массива
        def show
          DATASET.with_pk!(id)
        end

        private

        # Возвращает `id`
        def id
          params[:id]
        end
      end
    end
  end
end
