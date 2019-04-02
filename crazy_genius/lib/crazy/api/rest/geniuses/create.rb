# frozen_string_literal: true

module Crazy
  module API
    module REST
      # Добавление метода, который создает запись об ученом
      module Geniuses
        # Добавление метода, создающего запись об ученом
        module Create
          #  Регистрация API метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          #   REST API контроллер
          def self.registered(controller)
            # Добавлятся запись об ученом
            # и возвращает информацию о записи
            # @param [String] request_body
            #   Структура параметров описана:
            #   {Actions::Geniuses::Create::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   Структура результата описана:
            #   {Actions::Geniuses::Create::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   201
            controller.post '/geniuses' do
              content = Actions::Geniuses.create(request.body)
              status :created
              body Oj.dump(content)
            end
          end
        end

        Controller.register Create
      end
    end
  end
end
