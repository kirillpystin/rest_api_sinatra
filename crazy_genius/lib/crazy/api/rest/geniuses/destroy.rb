# frozen_string_literal: true

module Crazy
  module API
    module REST
      module Geniuses
        # Добавление метода, удаляющего запись об ученом
        module Destroy
          # Регистрация метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          #   REST API контроллер
          def self.registered(controller)
            # Удаление записи об ученом
            # @return [Status]
            #   204
            controller.delete '/geniuses/:id' do |id|
              Actions::Geniuses.destroy(id: id)
              status :no_content
            end
          end
        end

        Controller.register Destroy
      end
    end
  end
end
