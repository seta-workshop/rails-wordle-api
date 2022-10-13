# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    name     { Faker::Name.name }
    email    { Faker::Internet.email }
    password { Faker::Internet.password }
    unconfirmed_email { Faker::Internet.email }
  end
end
