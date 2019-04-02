# frozen_string_literal: true

module Crazy
  module API
    module REST
      module Geniuses
        # Добавление метода, выводящего информацию об ученых
        module Index
          # Регистрация метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          #   REST API контроллер
          def self.registered(controller)
            # Получаются записи об ученых
            # и возвращается информация о записях
            # @param [String] request_body
            #   Структура параметров описана:
            #   {Actions::Geniuses::Index::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   Структура резульатов описана:
            #   {Actions::Geniuses::Index::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   200
            controller.get '/geniuses' do
              content = Actions::Geniuses.index(request.GET)
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
