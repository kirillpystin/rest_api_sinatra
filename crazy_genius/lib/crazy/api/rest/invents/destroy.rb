# frozen_string_literal: true

module Crazy
  module API
    module REST
      module Invents
        # Добавление метода, удаляющего запись об изобретении
        module Destroy
          # Регистрация метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          #   REST API контроллер
          def self.registered(controller)
            # Удаление записи
            # @return [Status]
            #   204
            controller.delete '/invents/:id' do |id|
              Actions::Invents.destroy(id: id)
              status :no_content
            end
          end
        end

        Controller.register Destroy
      end
    end
  end
end
