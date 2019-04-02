# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/geniuses/create/result_schema"

  module API
    # Модуль, отвечающий за за создание записи об ученом
    module REST
      module Geniuses
        module Create
          # Добавлются методы,
          # используемые в тестах метода REST API,
          # определенных в
          # содержащем их модуле
          module SpecHelper
            # Возварщает JSON-схему REST API метода
            # @return [Hash]
            #   JSON-схема REST API метода
            def schema
              Actions::Geniuses::Create::RESULT_SCHEMA
            end
          end
        end
      end
    end
  end
end
