# frozen_string_literal: true

module Crazy
  module Actions
    require "#{Crazy.actions_dir}/uuid_format"

    module Geniuses
      class Destroy
        # JSON-схема для параметров
        PARAMS_SCHEMA = {
          type: :object,
          properties: {
            id: {
              type: :string,
              pattern: UUID_FORMAT
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
