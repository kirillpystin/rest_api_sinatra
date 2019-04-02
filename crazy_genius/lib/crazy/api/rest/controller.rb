# frozen_string_literal: true

require 'sinatra/base'

module Crazy
  module API
    module REST
      # Класс REST API контроллера
      class Controller < Sinatra::Base
        # Тип данных, принимаемый в теле запроса по умолчанию
        CONTENT_TYPE = 'application/json; charset=utf-8'

        before { content_type CONTENT_TYPE }
      end
    end
  end
end
