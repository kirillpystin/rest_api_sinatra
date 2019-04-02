# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/geniuses/index/result_schema"

  module API
    # Модуль, отвечающий за вывод информации об ученых
    module REST
      module Geniuses
        module Index
          # Добавлются методы,
          # используемые в тестах метода REST API,
          # определенных в содержащем их модуле
          module SpecHelper
            # Возварщает JSON-схему REST API метода
            # @return [Hash]
            #   JSON-схема REST API метода
            def schema
              Actions::Geniuses::Index::RESULT_SCHEMA
            end
          end
        end
      end
    end
  end
end
