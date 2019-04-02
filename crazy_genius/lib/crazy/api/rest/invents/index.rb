# frozen_string_literal: true

module Crazy
  module API
    module REST
      module Invents
        # Модуль, отвечающий за REST API метод,
        # который выдает информацию об изобретениях
        module Index
          # Регистрация метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          #   REST API контроллер
          def self.registered(controller)
            # Извлекаются записи об изобретениях
            # и возвращается информация о записях
            # @param [String] request_body
            #   Структура параметров описана:
            #   {Actions::Invents::Index::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   Структура результатов описана:
            #   {Actions::Invents::Index::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   200
            controller.get '/geniuses/:id/invents' do |id|
              rest = { genius_id: id }
              content = Actions::Invents.index(request.GET, rest)
              status :ok
              body Oj.dump(content)
            end
          end
        end

        Controller.register Index
      end
    end
  end
end
