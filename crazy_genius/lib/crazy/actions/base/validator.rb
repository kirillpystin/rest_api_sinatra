# frozen_string_literal: true

require 'json-schema'

module Crazy
  # Добавлюяются действия над объектами
  module Actions
    # Модуль, отвчающий за методы,
    # которые являются общими для всех действий
    module Base
      # Модуль,позволяющий проверять соответствие данных json-схеме
      module Validator
        # Проверяет,
        # соответствует ли предоставленная структура данных JSON-схеме.
        # Предполагается, что ключи внутренних ассоциативных массивов
        # являются строками
        # @param [Object] data
        #   структура данных
        # @raise [JSON::Schema::ValidationError]
        #   если структура данных не соответствует json-схеме
        def validate!(data)
          validator.instance_exec do
            @data = data
            validate
          end
        end

        # Возвращает копию предоставленной структуры данных с всеми ключами
        # внутренних ассоциативных массивов, приведенные к строкам
        # @param [Object] data
        #   структура данных
        # @return [Object]
        #   копия структуры данных
        def stringify(data)
          JSON::Schema.stringify(data)
        end

        private

        # Возвращает JSON-схему, извлекая константу `PARAMS_SCHEMA` из класса
        # @return [Hash]
        #   JSON-схема
        # @raise [NameError]
        #   если константа `PARAMS_SCHEMA` отсутствует
        def schema
          self::PARAMS_SCHEMA
        end

        # Ассоциативный массив с параметрами валидации JSON-схемы
        VALIDATOR_OPTIONS = { parse_data: false }.freeze

        # Возвращение валидатора JSON-схемы
        # @return [JSON::Validator]
        #   валидатор JSON-схемы
        def validator
          @validator ||= JSON::Validator.new(schema, nil, VALIDATOR_OPTIONS)
        end
      end
    end
  end
end
