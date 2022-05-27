FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4) }
    question
    user
  end
end
