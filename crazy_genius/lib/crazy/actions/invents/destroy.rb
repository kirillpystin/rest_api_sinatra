# frozen_string_literal: true

module Crazy
  module Actions
    module Invents
      # Класс для удаление записи о изобретении
      class Destroy < Base::Action
        require_relative 'destroy/params_schema'

        # Удаляет запись
        def destroy
          record.destroy
        end

        private

        # Возвращает значение 'id'
        def id
          params[:id]
        end

        # Возвращает запись по 'id'
        # @return [Crazy::Models::Invent]
        # запись
        # @raise [Sequel::NoMatchingRow]
        #   если не получилось найти запись
        def record
          Models::Invent.with_pk!(id)
        end
      end
    end
  end
end
