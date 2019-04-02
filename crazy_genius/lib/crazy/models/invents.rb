# frozen_string_literal: true

module Crazy
  # Модуль,твечающий за модель изобретения
  module Models
    # Класс,отвечающий за модель изобретения
    class Invent < Sequel::Model
      unrestrict_primary_key
    end
  end
end
