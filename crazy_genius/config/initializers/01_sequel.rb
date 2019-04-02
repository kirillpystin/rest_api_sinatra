# frozen_string_literal: true

require 'sequel'
require 'erb'
require 'yaml'

Sequel.extension :migration
Sequel.extension :core_extensions

# Получение параметров для подключения к базе данных
erb = IO.read("#{Crazy.path}/config/database.yml")
yaml = ERB.new(erb).result
options = YAML.safe_load(yaml, [], [], true)

# Соединение с базой данных
Sequel::Model.db = Sequel.connect(options[Crazy.env])

Sequel::Model.raise_on_save_failure = true
Sequel::Model.raise_on_typecast_failure = true
