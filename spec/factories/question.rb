# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentence(word_count: 3) }
    body { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    user
  end

  trait :with_answers do
    answers { FactoryBot.create_list(:answer, Faker::Number.non_zero_digit) }
  end
end
