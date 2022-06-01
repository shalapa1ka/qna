# frozen_string_literal: true

require 'rails_helper'

feature 'CRUD test for answer' do
  given(:user) { create :user }
  given(:other_user) { create :user }
  given(:admin) { create :user, :admin }
  given(:question) { create :question, user: user }
  given(:answer) { create :answer, user: user, question: question }

  scenario 'Signed in user creating\updating\deleting answer', js: true do
    sing_in_user user
    expect(page).to have_content 'Signed in successfully.'

    visit question_path(question)
    new_answer
    expect(page).to have_content 'Answer successfully created!'
    expect(page).to have_content "User: #{user.name}"
    expect(page).to have_content 'Test title'

    edit_answer
    expect(page).to have_content 'Answer successfully edited!'

    click_on 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Answer successfully deleted!'
  end

  scenario 'User try to edit or delete not his answer' do
    sing_in_user other_user
    visit edit_question_answer_path(question, answer)
    expect(page).to have_content 'You are not authorized to perform this action!'
  end

  scenario 'Admin try to edit or delete not his question' do
    sing_in_user admin
    visit edit_question_answer_path(question, answer)
    expect(page).to have_content 'Editing answer'
  end
end
