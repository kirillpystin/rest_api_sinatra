# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/geniuses/index/result_schema"

  # Модуль для тестирования действия
  module Actions
    # Модуль для тестирования класса Geniuses
    module Geniuses
      # Добавление хэлпера для тестирования вывода информации об ученых
      class Index
        module SpecHelper
          def schema
            RESULT_SCHEMA
          end

          # Массив значения для полей таблицы `geniuses`
          COLUMNS = %i[id name crazy try_kill created].freeze

          # Массив значения для тестовой записей об ученых
          GENIUSES = [
            ['8abd8754-e1eb-459e-b71a-c0247d58139f', '1', 2, 3, Time.now - 1],
            ['2d1d9454-a5de-4bb9-ab24-c73032e8252b', '2', 1, 4, Time.now - 2],
            ['6b3e3022-3726-41dd-8cf0-726b3a90f546', '3', 0, 5, Time.now - 3]
          ].freeze

          # Создание записей об ученых и возращение массива с ними

          def create_genius
            GENIUSES.map do |values|
              params = Hash[COLUMNS.zip(values)]
              Models::Geniuses.create(params)
            end
          end
        end
      end
    end
  end
end
