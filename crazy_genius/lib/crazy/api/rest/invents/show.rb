# frozen_string_literal: true

module Crazy
  module API
    module REST
      module Invents
        # Модуль, отвечающий за REST API метод,
        # который выдает информацию об изобретениии
        module Show
          # Регистрация метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          # REST API контроллер
          def self.registered(controller)
            # Выводит информацию об изобретении
            # @param [String] request_body
            #   Структура параметров описана:
            #   {Actions::Invents::Show::PARAMS_SCHEMA JSON-schema}
            # @return [String]
            #   Структура резульатов описана:
            #   {Actions::Invents::Show::RESULT_SCHEMA JSON-schema}
            # @return [Status]
            #   200
            controller.get '/invents/:id' do |id|
              content = Actions::Invents.show(id: id)
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
