# frozen_string_literal: true

module BestAnswerMacros
  def set_best
    visit question_path(question)
    within("#answer_#{best_answer.id}") do
      expect(page).to have_content 'Best Answer'
    end
    within("#answer_#{answer.id}") do
      click_on 'Set best'
      expect(page).to have_content 'Best Answer'
    end
    within("#answer_#{best_answer.id}") do
      expect(page).not_to have_content 'Best Answer'
    end
  end
end
