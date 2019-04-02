# frozen_string_literal: true

module Crazy
  require "#{Crazy.actions_dir}/uuid_format"

  module Actions
    module Invents
      class Create
        # JSON-схема для результатов вызова
        RESULT_SCHEMA = {
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
