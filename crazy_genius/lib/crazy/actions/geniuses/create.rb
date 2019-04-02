# frozen_string_literal: true

require 'securerandom'

module Crazy
  module Actions
    module Geniuses
      # Класс создания новой записи об ученом
      class Create < Base::Action
        require_relative 'create/params_schema'

        # Создает новую запись об ученом и возвращает ассоциативный массив
        # с информацией о записи
        # @return [Hash]
        def create
          record = Models::Geniuses.create(creation_params)
          { id: record.id }
        end

        private

        # Устанавливает значения для передаваемых параметров
        # @return [Hash]
        def creation_params
          params.dup.tap do |hash|
            hash[:id]         = SecureRandom.uuid
            hash[:created]    = Time.now
          end
        end
      end
    end
  end
end
