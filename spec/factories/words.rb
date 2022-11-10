# frozen_string_literal: true

FactoryBot.define do
  factory :word do
      kind { 'basic' }
      value { Faker::Lorem.characters(number: 5) }
    # trait :basic do
    #   kind { 'basic' }
    #   value { Faker::Lorem.words(5) }
    # end

    # trait :scientific do
    #   kind { 'scientific' }
    #   value { Faker::Science.science(5) }
    # end
  end
end
