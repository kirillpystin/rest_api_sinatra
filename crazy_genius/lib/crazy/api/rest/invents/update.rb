# frozen_string_literal: true

module Crazy
  module API
    module REST
      module Invents
        # Добавление метода, который обновляет запись об изобретении
        module Update
          # Регистрация метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          # REST API контроллер
          def self.registered(controller)
            # Обновляет информацию об изобретении
            # @param [String] request_body
            #   Структура параметров описана:
            #   {Actions::Invents::Update::PARAMS_SCHEMA JSON-schema}
            # @return [Status]
            #   204
            controller.put '/invents/:id' do |id|
              Actions::Invents.update(request.body, id: id)
              status :no_content
            end
          end
        end

        Controller.register Update
      end
    end
  end
end
