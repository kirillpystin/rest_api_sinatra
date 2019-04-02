# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/invents/create/result_schema"

  module API
    module REST
      # Модуль, отвечающий за создание записи об изобретении
      module Invents
        module Create
          # Добавлются методы,
          # используемые в тестах метода REST API,
          # определенных в содержащем их модуле
          module SpecHelper
            # Возварщает JSON-схему REST API метода
            # @return [Hash]
            #   JSON-схема REST API метода
            def schema
              Actions::Invents::Create::RESULT_SCHEMA
            end
          end
        end
      end
    end
  end
end
