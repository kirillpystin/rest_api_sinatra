# frozen_string_literal: true

module Crazy
  module Actions
    module Geniuses
      # Класс для удаления записи об ученом
      class Destroy < Base::Action
        require_relative 'destroy/params_schema'

        # Удаления записи
        def destroy
          record.destroy
        end

        private

        # Возвращает `id`
        # @return [String]
        def id
          params[:id]
        end

        # Возвращает запись по 'id'
        # @return [Crazy::Models::Geniuses]
        # запись
        # @raise [Sequel::NoMatchingRow]
        #   если не получилось найти запись
        def record
          Models::Geniuses.with_pk!(id)
        end
      end
    end
  end
end
