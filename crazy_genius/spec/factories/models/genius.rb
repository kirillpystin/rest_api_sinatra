# frozen_string_literal: true

FactoryBot.define do
  factory :genius, class: Crazy::Models::Geniuses do
    id         { create(:uuid) }
    name       { create(:string) }
    try_kill   { create(:integer) }
    crazy      { create(:integer) }
    created { Time.now }
  end
end
