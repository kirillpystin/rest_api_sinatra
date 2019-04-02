# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/geniuses/create/result_schema"

  # Модуль для тестирования действия
  module Actions
    # Модуль для хелпера класса Geniuses
    module Geniuses
      # Добавление хэлпера для тестирования создания записи об ученом
      class Create
        module SpecHelper
          def schema
            RESULT_SCHEMA
          end
        end
      end
    end
  end
end
