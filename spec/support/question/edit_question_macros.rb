# frozen_string_literal: true

module EditQuestionMacros
  def edit_question
    click_on 'Edit'
    fill_in 'Title', with: 'Edited title'
    fill_in 'Tell about your question', with: 'Edited body'
    click_on 'Update Question'
  end
end
