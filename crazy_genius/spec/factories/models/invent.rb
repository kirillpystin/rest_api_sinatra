# frozen_string_literal: true

FactoryBot.define do
  factory :invent, class: Crazy::Models::Invent do
    id               { create(:uuid) }
    name             { create(:string) }
    power            { create(:integer) }
    created_at       { Time.now }
    genius_id        { create(:genius).id }
  end
end
