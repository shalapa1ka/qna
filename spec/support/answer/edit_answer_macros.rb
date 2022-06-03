# frozen_string_literal: true

module EditAnswerMacros
  def edit_answer
    click_on 'Edit'
    within('#answers') do
      fill_in 'Answer', with: 'Edited title'
      click_on 'Update Answer'
    end
  end
end
