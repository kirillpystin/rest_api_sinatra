# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:geniuses) do
      column :id,         :uuid, primary_key: true
      column :name,       :text, null: false
      column :crazy,      :integer, null: false, default: 0
      column :try_kill,   :integer, null: false, default: 0
      column :created,    :timestamp, null: false

      constraint(:genius_crazy_non_negativeness) { crazy >= 0 }
      constraint(:genius_try_kill_non_negativeness) { try_kill >= 0 }
    end
  end
end
