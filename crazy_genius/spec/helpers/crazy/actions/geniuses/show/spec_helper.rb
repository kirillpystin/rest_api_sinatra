# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/geniuses/show/result_schema"

  # Модуль для тестирования действия
  module Actions
    # Модуль для тестирования класса Geniuses
    module Geniuses
      # Добавление хэлпера для тестирования вывода информации об ученом
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
