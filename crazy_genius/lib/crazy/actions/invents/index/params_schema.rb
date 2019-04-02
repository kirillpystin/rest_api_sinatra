# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/uuid_format"

  module Actions
    module Invents
      class Index
        # JSON-схема параметров действия
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
            genius_id: {
              type: :string,
              pattern: UUID_FORMAT
            },
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
              enum: Models::Invent.columns.map(&:to_s)
            },
            direction: {
              type: :string,
              enum: %w[asc desc]
            }
          },
          required: %i[
            genius_id
          ],
          additionalProperties: false
        }.freeze
      end
    end
  end
end
