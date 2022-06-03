# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    after(:create) do |u|
      u.confirm
      u.skip_confirmation_notification!
    end

    name { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    admin { false }

    trait :admin do
      admin { true }
    end
  end
end
