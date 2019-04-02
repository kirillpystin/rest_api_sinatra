# frozen_string_literal: true

require_relative '../support/factory_bot'

# Добавляем поддержку Sequel
FactoryBot.define do
  to_create(&:save)
end
