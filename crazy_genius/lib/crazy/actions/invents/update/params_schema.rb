# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/uuid_format"

  module Actions
    module Invents
      class Update
        # JSON-схема параметров действия
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
            power: {
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
