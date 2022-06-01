# frozen_string_literal: true

module NewAnswerMacros
  def new_answer
    fill_in 'Answer', with: 'Test title'
    click_on 'Answer'
  end
end
