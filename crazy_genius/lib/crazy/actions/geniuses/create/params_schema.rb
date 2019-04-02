# frozen_string_literal: true

module Crazy
  module Actions
    module Geniuses
      class Create
        # JSON-схема для параметров
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
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
            name
          ],
          additionalProperties: false
        }.freeze
      end
    end
  end
end
