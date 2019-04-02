# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/geniuses/show/result_schema"

  module API
    module REST
      # Модуль, отвечающий за вывод записи об ученом
      module Geniuses
        module Show
          # Добавлются методы,
          # используемые в тестах метода REST API,
          # определенных в содержащем их модуле
          module SpecHelper
            # Возварщает JSON-схему REST API метода
            # @return [Hash]
            #   JSON-схема REST API метода
            def schema
              Actions::Geniuses::Show::RESULT_SCHEMA
            end
          end
        end
      end
    end
  end
end
