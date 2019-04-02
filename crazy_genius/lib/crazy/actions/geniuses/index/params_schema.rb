# frozen_string_literal: true

module Crazy
  module Actions
    module Geniuses
      class Index
        # JSON-схема для параметров
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
            page: {
              type: :integer,
              minimun: 0
            },
            page_size: {
              type: :integer,
              minimum: 1,
              maximum: 20
            },
            order: {
              type: :string,
              enum: Models::Geniuses.columns.map(&:to_s)
            },
            direction: {
              type: :string,
              enum: %w[asc desc]
            }
          },
          additionalProperties: false
        }.freeze
      end
    end
  end
end
