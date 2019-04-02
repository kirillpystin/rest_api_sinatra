# frozen_string_literal: true

module Crazy
  module Actions
    module Geniuses
      # Класс, извлекающий информацию об ученых
      class Index < Base::Action
        require_relative 'index/params_schema'

        # Извлечение массива с информацией об ученых
        # @return [Array]
        # получение массива
        def index
          dataset.to_a
        end

        private

        # Возвращает значение `page` или 0, если его нет
        # @return [Integer]
        #  получение значения
        def page
          params[:page] || 0
        end

        # Значение для 'page_size', которое будет установлено,
        # если 'page_size' отсутствует
        DEFAULT_PAGE_SIZE = 10

        # Возвращение значения `page_size` или установка 'DEFAULT_PAGE_SIZE',
        # если его нет
        # @return [Integer]
        # получение значеяния
        def page_size
          params[:page_size] || DEFAULT_PAGE_SIZE
        end

        # Сортировка по умолчнию(по возрастанию)
        DEFAULT_DIRECTION = 'asc'

        # Возвращает значение `direction` или устанавливает 'DEFAULT_DIRECTION',
        # если это значние пустое
        def direction
          params[:direction] || DEFAULT_DIRECTION
        end

        # Поле для сортировки по умолчанию
        DEFAULT_ORDER = 'id'

        # Установка поля и типа сортировки
        def order
          order = params[:order] || DEFAULT_ORDER
          order.to_sym.send(direction)
        end

        # Возвращает число записей в наборе данных
        def offset
          page * page_size
        end

        # Sequel запрос, который извлекает значения поля`created_at`
        # в таблице `geniuses`
        CREATED =
          :to_char
          .sql_function(:created, 'YYYY-mm-dd HH:MM:SS')
          .as(:created)

        # Массив, который извлекает значния полей из таблицы 'geniuses'
        COLUMNS = [
          :id,
          :name,
          :crazy,
          :try_kill,
          CREATED
        ].freeze

        # Набор данных, извлекаемый из таблицы `geniuses`
        DATASET = Models::Geniuses.select(*COLUMNS).naked

        # Возвращает отсортированный набор данных из таблицы `geniuses`
        # @return [Sequel::Dataset]
        # получение набора данных
        def dataset
          DATASET.order(order).limit(page_size).offset(offset)
        end
      end
    end
  end
end
