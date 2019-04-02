# frozen_string_literal: true

require_relative 'validator'

module Crazy
  # Добавлюяются действия над объектами
  module Actions
    # Модуль, отвчающий за методы,
    # которые являются общими для всех действий
    module Base
      # Класс действия, который проверяет,
      # что парметры действия соответствуют json-схеме
      class Action
        extend Validator

        # Инициализирует объект
        # @param [Object] params
        #   Объект с параметрами действия,
        # который может быть как ассоциативным массивом,
        # json-строкой, так и другим объектом,
        # имеющим метод `read`
        # @param [NilClass, Hash] rest
        #  ассоциативный массив дополнительных парметров или `nil`,
        # если дополнительные параметры отсутствуют
        # @raise [Oj::ParseError, EncodingError]
        #  если `params`-строка, но не JSON-строка
        # @raise [JSON::Schema::ValidationError]
        #  если ассоциативный массив парметров действия
        # не соответствует json-схеме
        def initialize(params, rest = nil)
          @params = process_params(params, rest)
        end

        private

        # Ассоциативный массив парметров действия
        # @return [Hash{Symbol => Object}]
        attr_reader :params

        # Извлекает ассоциативный массив параметров действия из предоставленного
        # аргумента, проверяет на соответствие JSON-схеме и возвращает его
        # @param [Hash{Symbol => Object}] hash
        # ассоциативный массив парметров действия
        # @param [NilClass, Hash] rest
        # ассоциативный массив дополнительных парметров или `nil`,
        # если дополнительные параметры отсутствуют
        # @return [Hash{Symbol => Object}]
        #   ассоциативный массив парметров действия
        # @raise [JSON::Schema::ValidationError]
        #  если ассоциативный массив парметров действия
        # не передает json-схему
        def process_params(params, rest)
          return process_hash(params, rest) if params.is_a?(Hash)
          return process_json(params, rest) if params.is_a?(String)
          return process_read(params, rest) if params.respond_to?(:read)

          # Вызывает JSON::Schema::ValidationError, если `params` некорректно
          validate!(params)
        end

        # Добавляет дополнительные параметры действия в ассоциативный массив
        #  параметров действия, если они предоставлены,
        # проверяет их, если результат
        # cоответствует JSON-схеме, то возвращает ее
        # @param [Hash{Symbol => Object}] hash
        #   ассоциативный массив парметров действия
        # @param [NilClass, Hash] rest
        # ассоциативный массив дополнительных парметров или `nil`,
        # если дополнительные параметры отсутствуют
        # @return [Hash{Symbol => Object}]
        #   ассоциативный массив парметров действия
        # @raise [JSON::Schema::ValidationError]
        #  если ассоциативный массив парметров действия
        # не передает json-схему
        def process_hash(hash, rest)
          result = rest.nil? ? hash : hash.merge(rest)
          result.tap { validate!(stringify(result)) }
        end

        # Параметры для функции `Oj.load` для восстановление структуры
        # данных из JSON-строк с строковыми ключами
        # из внутренних ассоциативных массивов
        STRING_KEYS = { symbol_keys: false }.freeze

        # Этапы:
        # 1.  Восстанавление структуры данных из JSON-строки.
        # 2.  Проверка, если стркутруа данных - ассоциативный массив.
        # 3.  Добавление дополнительных параметров действия
        # в ассоциативный массив.
        # 4.  Проверка, если получившийся ассоциативный массив
        # передает json-схему.
        # 5.  Возварщает ассоциативный массив.
        # @param [String] json
        #   JSON-строка
        # @param [NilClass, Hash] rest
        #   ассоциативный массив дополнительных парметров или `nil`,
        # если дополнительные параметры отсутствуют
        # @return [Hash{Symbol => Object}]
        #   ассоциативный массив парметров действия
        # @raise [Oj::ParseError, EncodingError]
        #   если `json` аргумент строка, но не json-строка
        # @raise [JSON::Schema::ValidationError]
        #   если ассоциативный массив парметров действия не передает json-схему
        def process_json(json, rest)
          # Восстановление по строковым ключам
          data = Oj.load(json, STRING_KEYS)
          # Вызывает JSON::Schema::ValidationError,
          # если с восстановленно стркутурой данных что-то не так
          validate!(data) unless data.is_a?(Hash)
          data.update(stringify(rest)) unless rest.nil?
          validate!(data)
          # Восстановление по символьным ключам
          data = Oj.load(json)
          rest.nil? ? data : data.update(rest)
        end

        # Выполняемые этапы:
        # 1. Вызывается местод `#rewind` предоставленного объекта,
        # если он поддерживается
        # 2. Используется метод `#read` предосталенного объекта,
        # для получения строки.
        # 3. Вызывается {process_json} для строки и возвращается результат
        # @param [#read] stream
        #   потоковый объект
        # @param [NilClass, Hash] rest
        #   ассоциативный массив дополнительных парметров или `nil`,
        # если дополнительные параметры отсутствуют
        # @return [Hash{Symbol => Object}]
        #   ассоциативный массив парметров действия
        # @raise [Oj::ParseError, EncodingError]
        #   если `json` аргумент строка, но не json-строка
        # @raise [JSON::Schema::ValidationError]
        # если восстановленный ассоциативный массив
        # параметров действия не передает json-схему
        def process_read(stream, rest)
          stream.rewind if stream.respond_to?(:rewind)
          process_json(stream.read.to_s, rest)
        end

        # Проверяет,
        # соответствует ли предоставленная структура данных JSON-схеме.
        # Предполагается,
        # что ключи внутренних ассоциативных массивов являются строками.
        # @param [Object] data
        #   структура данных
        # @raise [JSON::Schema::ValidationError]
        #   если структура данных не json-схема
        def validate!(data)
          self.class.validate!(data)
        end

        # Возвращает копию предоставленной структуры данных с всеми ключами
        # внутренних ассоциативных массивов, приведенные к строкам
        # @param [Object] data
        #   Структура данных
        # @return [Object]
        #   результат копирования структуры данных
        def stringify(data)
          self.class.stringify(data)
        end
      end
    end
  end
end
