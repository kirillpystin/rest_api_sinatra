# frozen_string_literal: true

module Crazy
  require "#{Crazy.path}/lib/crazy/version"

  module API
    module REST
      # Добавление метода для контроля версии приложения
      module Version
        # Добавление метода для REST API, выводящего информацию о версии
        module Show
          # Ассрциативный массив с версией приложения
          CONTENT = {
            version: Crazy::VERSION,
            hostname: `hostname`.strip
          }.freeze

          # Тело ответа метода
          BODY = Oj.dump(CONTENT).freeze

          # Регистрация REST API метода в REST API контроллере
          # @param [Crazy::API::REST::Controller] controller
          #   REST API контроллер
          def self.registered(controller)
            # Получение информации о версии приложения
            # @return [Hash]
            #   Ассоциативный массив с информацией о версии
            # @return [Status]
            #   200
            controller.get '/version' do
              status :ok
              body BODY
            end
          end
        end

        Controller.register Show
      end
    end
  end
end
