# frozen_string_literal: true

module Crazy
  module Actions
    # Формат записи HEX числа
    HEX = '[a-fA-F0-9]'

    # Выборка 4 символов по соответствию `HEX`
    HEX4 = "#{HEX}{4}"
    # Выборка 8 символов по соответствию `HEX`
    HEX8 = "#{HEX}{8}"
    # Выборка 12 символов по соответствию `HEX`
    HEX12 = "#{HEX}{12}"
    # Регулярное выражение для проверки строки на соответствие UUID формату
    UUID_FORMAT = /\A#{HEX8}-#{HEX4}-#{HEX4}-#{HEX4}-#{HEX12}\z/.freeze
  end
end
