# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/invents/index/result_schema"

  # Модуль для тестирования действия
  module Actions
    # Модуль для хелпера класса Invents
    module Invents
      # Добавление хэлпера для тестирования вывода информации об изобретенях
      class Index
        module SpecHelper
          def schema
            RESULT_SCHEMA
          end

          # Массив названий полей для записей `invents`
          COLUMNS = %i[id name power created_at].freeze

          # Массив значений для тестовых записей `invents`
          INVENTS = [
            ['8abd8754-e1eb-459e-b71a-c0247d58139f', '1', 3, Time.now - 1],
            ['2d1d9454-a5de-4bb9-ab24-c73032e8252b', '2', 4, Time.now - 2],
            ['6b3e3022-3726-41dd-8cf0-726b3a90f546', '3', 5, Time.now - 3]
          ].freeze

          # Создание записей об изобретениях
          def create_invents(genius_id)
            INVENTS.map do |values|
              params = Hash[COLUMNS.zip(values)]
              params[:genius_id] = genius_id
              Models::Invent.create(params)
            end
          end
        end
      end
    end
  end
end
