# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    question
    user
    best { false }
  end

  trait :best do
    best { true }
  end
end
