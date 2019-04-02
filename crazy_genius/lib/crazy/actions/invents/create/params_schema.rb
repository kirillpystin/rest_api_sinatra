# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/uuid_format"

  module Actions
    module Invents
      class Create
        # JSON-схема параметров действия
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
            genius_id: {
              type: :string,
              pattern: UUID_FORMAT
            },
            name: {
              type: :string
            },
            power: {
              type: :integer,
              minimum: 0
            }
          },
          required: %i[
            genius_id
            name
          ],
          additionalProperties: false
        }.freeze
      end
    end
  end
end
