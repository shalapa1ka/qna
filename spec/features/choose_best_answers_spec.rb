# frozen_string_literal: true

require 'rails_helper'

feature 'choosing best answers for question by different users' do
  given(:user) { create :user }
  given(:admin) { create :user, :admin }
  given(:question) { create :question, user: user }
  given(:answer) { create :answer, user: user, question: question }
  given(:best_answer) { create :answer, :best, user: user, question: question }

  background do
    question.answers << answer
    question.answers << best_answer
  end

  scenario '- by user' do
    sing_in_user user
    set_best
  end

  scenario '- by user' do
    sing_in_user admin
    set_best
  end
end
