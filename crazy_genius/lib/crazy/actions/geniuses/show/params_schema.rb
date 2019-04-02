# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/uuid_format"

  module Actions
    module Geniuses
      class Show
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
