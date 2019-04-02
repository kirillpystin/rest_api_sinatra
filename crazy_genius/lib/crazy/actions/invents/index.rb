# frozen_string_literal: true

module Crazy
  module Actions
    module Invents
      # Класс для вывода всех изобретений
      class Index < Base::Action
        require_relative 'index/params_schema'

        # Вывод массива с информацией о изобретениях
        # @return [Array]
        # получение массива
        def index
          dataset.to_a
        end

        private

        # Возвращает значение для 'genius_id'
        def genius_id
          params[:genius_id]
        end

        # Находит запись об ученом по 'id'
        # @return [Crazy::Models::Geniuses]
        # запись
        # @raise [Sequel::NoMatchingRow]
        #   если не получилось найти запись
        def genius
          Models::Geniuses.with_pk!(genius_id)
        end

        # Выводит количество страниц либо присваевает значение 0
        def page
          params[:page] || 0
        end

        # Устанавливает количество записей, выводимое на страницу
        DEFAULT_PAGE_SIZE = 10

        # Возвращение значения `page_size` или установка 'DEFAULT_PAGE_SIZE',
        # если его нет
        # @return [Integer]
        # получение значеяния
        def page_size
          params[:page_size] || DEFAULT_PAGE_SIZE
        end

        # Тип сортировки по умолчанию
        DEFAULT_DIRECTION = 'asc'

        # Возвращает тип сортировки`direction`
        # или устанавливает из'DEFAULT_DIRECTION',
        # если он пустой
        def direction
          params[:direction] || DEFAULT_DIRECTION
        end

        # Сортировка по 'id'
        DEFAULT_ORDER = 'id'

        # Установка поля и типа сортировки
        def order
          order = params[:order] || DEFAULT_ORDER
          order.to_sym.send(direction)
        end

        # Выводит общее количество записей

        def offset
          page * page_size
        end

        # Выражение для извлечение поля `created_at`
        CREATED_AT =
          :to_char
          .sql_function(:created_at, 'YYYY-mm-dd HH:MM:SS')
          .as(:created_at)

        # Массив полей для записей в таблице 'invents'
        COLUMNS = [:id, :name, :power, CREATED_AT].freeze

        # Набор записей 'Invents'
        DATASET = Models::Invent.select(*COLUMNS).naked

        # Возвращает отсортированный набор данных из таблицы `geniuses`
        # @return [Sequel::Dataset]
        # получение набора данных
        def dataset
          DATASET
            .where(genius_id: genius.id)
            .order(order)
            .limit(page_size)
            .offset(offset)
        end
      end
    end
  end
end
