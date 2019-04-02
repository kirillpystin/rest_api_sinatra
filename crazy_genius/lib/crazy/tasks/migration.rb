# frozen_string_literal: true

module Crazy
  # Модуль, отвеающий за миграцию базы данных
  module Tasks
    # Класс, отвеающий за миграцию базы данных
    class Migration
      attr_reader :dir

      def initialize(dir)
        @dir = dir
      end

      # Метод,отвеающий за миграцию базы данных
      def launch!
        Sequel::Migrator.run(Sequel::Model.db, dir)
        p "Миграция #{Sequel::Model.db.opts[:database]} успешно окончена"
      end
    end
  end
end
