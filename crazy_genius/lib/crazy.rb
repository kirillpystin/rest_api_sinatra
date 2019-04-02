# frozen_string_literal: true

# Модуль для управления доступом к переменным окружения
module Crazy
  require_relative 'crazy/init'

  # Метод логгирования
  def self.logger
    Init.settings.logger
  end
  # значение `RACK_ENV` переменной окружения для разработки
  DEVELOPMENT = 'development'
  # значение `RACK_ENV` переменной окружения для тестирования
  TEST = 'test'
  # значение `RACK_ENV` переменной окружения для размещения
  PRODUCTION = 'production'

  # Массив доступных окружений
  ENVIRONMENTS = [DEVELOPMENT, TEST, PRODUCTION].freeze

  # возвращает значения `RACK_ENV` переменной окружения или {DEVELOPMENT},
  # если переменная окружения не поддерживается
  def self.env
    value = ENV['RACK_ENV']
    ENVIRONMENTS.include?(value) ? value : DEVELOPMENT
  end

  # проверка установленного окружения
  def self.development?
    env == DEVELOPMENT
  end

  def self.test?
    env == TEST
  end

  def self.production?
    env == PRODUCTION
  end

  # Метод, используемый для упрощения маршрута к файлу
  def self.path
    File.absolute_path("#{__dir__}/..")
  end

  # Метод, используемый для упрощения маршрута к папке 'actions'
  def self.actions_dir
    File.absolute_path("#{__dir__}/crazy/actions")
  end

  # Метод, используемый для упрощения маршрута к папке 'rest'
  def self.rest_dir
    File.absolute_path("#{__dir__}/crazy/api/rest")
  end
end
