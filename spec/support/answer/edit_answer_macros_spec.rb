module EditAnswerMacros
  def edit_answer
    click_on 'Edit'
    fill_in 'Answer', with: 'Edited title'
    click_on 'Answer'
  end
end
