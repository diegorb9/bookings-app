# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    user
    date { '30/10/2019' }
    time { '08:00:00' }
    description { 'Foo bar' }
  end
end
