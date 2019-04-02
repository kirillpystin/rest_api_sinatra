# frozen_string_literal: true

module Crazy
  module API
    module REST
      module Geniuses
        # Модуль, отвечающий за REST API метод,
        # который выдает информацию об ученом
        module Show
          # Регистрация метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          # REST API контроллер
          def self.registered(controller)
            # Выводит информацию об ученом
            # @param [String] request_body
            #   Структура параметров описана:
            #   {Actions::Geniuses::Show::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   Структура результатов описана:
            #   {Actions::Geniuses::Show::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   200
            controller.get '/geniuses/:id' do |id|
              content = Actions::Geniuses.show(id: id)
              status :ok
              body Oj.dump(content)
            end
          end
        end

        Controller.register Show
      end
    end
  end
end
