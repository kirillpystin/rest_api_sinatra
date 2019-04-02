# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/uuid_format"

  module Actions
    module Geniuses
      class Update
        # JSON-схема для параметров
        PARAMS_SCHEMA = {
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
              minimun: 0
            }
          },
          required: %i[
            id
          ],
          additionalProperties: false
        }.freeze
      end
    end
  end
end
