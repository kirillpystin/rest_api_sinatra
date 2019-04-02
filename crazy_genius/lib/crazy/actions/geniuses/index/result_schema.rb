# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/uuid_format"
  require "#{Crazy.actions_dir}/datetime_format"

  module Actions
    module Geniuses
      class Index
        # JSON-схема для результатов вызова
        RESULT_SCHEMA = {
          type: :array,
          items: {
            type: :object,
            properties: {
              id: {
                type: :string,
                pattern: UUID_FORMAT
              },
              name: {
                type: :string
              },
              crazy: {
                type: :integer,
                minimum: 0
              },
              try_kill: {
                type: :integer,
                minimum: 0
              },
              created: {
                type: :string,
                pattern: DATETIME_FORMAT
              }
            },
            required: %i[
              id
              name
              crazy
              try_kill
              created
            ],
            additionalProperties: false
          }
        }.freeze
      end
    end
  end
end
