# frozen_string_literal: true

module Crazy
  module API
    module REST
      # Добавление метода, который создает запись об изобретении
      module Invents
        # Модуль, отвеающий за за создание записи об изобретении
        module Create
          # Регистрация API метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          #   REST API контроллер
          def self.registered(controller)
            # Добавлятся запись об изобретении и возвращает информацию о записи
            # @param [String] request_body
            #   Структура параметров описана:
            #   {Actions::Invents::Create::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   Структура результатов описана:
            #   {Actions::Invents::Create::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   201
            controller.post '/geniuses/:id/invents' do |id|
              rest = { genius_id: id }
              content = Actions::Invents.create(request.body, rest)
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
