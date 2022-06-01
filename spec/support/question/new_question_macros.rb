# frozen_string_literal: true

module NewQuestionMacros
  def new_question
    click_on 'Ask something'
    fill_in 'Title', with: 'Test title'
    fill_in 'Tell about your question', with: 'Test body'
    click_on 'Create Question'
  end
end
