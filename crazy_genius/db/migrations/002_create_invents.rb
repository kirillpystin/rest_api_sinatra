# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:invents) do
      column :id,         :uuid, primary_key: true
      column :name,       :text, null: false
      column :power,      :integer, null: false, default: 0
      column :created_at, :timestamp, null: false

      foreign_key :genius_id, :geniuses,
                  type: :uuid,
                  null: false,
                  index: true,
                  on_delete: :restrict,
                  on_update: :cascade

      constraint(:invent_non_negativeness) { power >= 0 }
    end
  end
end
