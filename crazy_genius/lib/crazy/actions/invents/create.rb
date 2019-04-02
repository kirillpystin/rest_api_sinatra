# frozen_string_literal: true

require 'securerandom'

module Crazy
  module Actions
    module Invents
      # Класс создания новой записи об изобретении
      class Create < Base::Action
        require_relative 'create/params_schema'

        # Создает запись об изобретении
        #  @return [Hash]
        # получение ассоциативного массива
        def create
          record = Models::Invent.create(creation_params)
          { id: record.id }
        end

        private

        # Возвращает 'genius_id'
        # @return [String]
        #  получение `genius_id`
        def genius_id
          params[:genius_id]
        end

        # Возвращает запись о ученом по 'genius_id'
        # @return [Crazy::Models::Geniuses]
        #   запись об ученом
        # @raise [Sequel::NoMatchingRow]
        #   если не удалось на  запись по `genius_id`
        def genius
          Models::Geniuses.with_pk!(genius_id)
        end

        # Устанавливает значения для передаваемых параметров,
        # для созданиявых записей
        # @return [Hash]
        # получение значений
        def creation_params
          params.slice(:name, :power).tap do |hash|
            hash[:genius_id]        = genius.id
            hash[:id]               = SecureRandom.uuid
            hash[:created_at]       = Time.now
          end
        end
      end
    end
  end
end
