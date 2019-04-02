# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/invents/show/result_schema"

  # Модуль для тестирования действия
  module Actions
    # Модуль для хелпера класса Invents
    module Invents
      # Добавление хэлпера для тестирования вывода информации об изобретении
      class Show
        module SpecHelper
          def schema
            RESULT_SCHEMA
          end
        end
      end
    end
  end
end
