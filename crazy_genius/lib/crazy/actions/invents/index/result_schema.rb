# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/uuid_format"
  require "#{Crazy.actions_dir}/datetime_format"

  module Actions
    module Invents
      class Index
        # JSON-схема результатов действия
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
              power: {
                type: :integer,
                minimum: 0
              },
              created_at: {
                type: :string,
                pattern: DATETIME_FORMAT
              }
            },
            required: %i[
              id
              name
              power
              created_at
            ],
            additionalProperties: false
          }
        }.freeze
      end
    end
  end
end
