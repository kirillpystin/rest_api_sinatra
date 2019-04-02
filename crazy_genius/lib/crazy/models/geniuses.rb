# frozen_string_literal: true

module Crazy
  # Модуль,отвечающий за модель ученого
  module Models
    # Создание модели ученого
    class Geniuses < Sequel::Model
      unrestrict_primary_key
    end
  end
end
