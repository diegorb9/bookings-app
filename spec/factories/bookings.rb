# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    user
    time { '08:00:00' }
    description { 'Foo bar' }
  end
end
