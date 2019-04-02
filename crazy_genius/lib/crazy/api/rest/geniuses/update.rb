# frozen_string_literal: true

module Crazy
  module API
    module REST
      module Geniuses
        # Добавление метода, который обновляет запись об ученом
        module Update
          # Регистрация метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          # REST API контроллер
          def self.registered(controller)
            # Обновляет информацию об ученом
            # @param [String] request_body
            #   Структура параметров описана:
            #   {Actions::Geniuses::Update::PARAMS_SCHEMA JSON-schema}
            # @return [Status]
            #   204
            controller.put '/geniuses/:id' do |id|
              Actions::Geniuses.update(request.body, id: id)
              status :no_content
            end
          end
        end

        Controller.register Update
      end
    end
  end
end
