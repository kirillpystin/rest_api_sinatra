# frozen_string_literal: true

module Crazy
  module Actions
    module Geniuses
      # Класс для обновления информации об ученом
      class Update < Base::Action
        require_relative 'update/params_schema'

        # Обновление информации об ученом
        def update
          record.update(update_params)
        end

        private

        # Возвращает `id`

        def id
          params[:id]
        end

        # Возвращает запись о ученом по 'id'
        # @return [Crazy::Models::Geniuses]
        #   запись
        # @raise [Sequel::NoMatchingRow]
        #   исключение, если запись не найдена
        def record
          Models::Geniuses.select(:id).with_pk!(id)
        end

        # Возвращает ассоциативный массив новых значений
        # @return [Hash]
        # получение ассоциативного массива
        def update_params
          params.except(:id)
        end
      end
    end
  end
end
