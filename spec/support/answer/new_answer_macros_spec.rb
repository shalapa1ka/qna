module NewAnswerMacros
  def new_answer
    click_on 'Answer it'
    fill_in 'Answer', with: 'Test title'
    click_on 'Answer'
  end
end
