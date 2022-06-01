require 'rails_helper'

feature 'CRUD test for question', js: true do
  given(:user) { create :user }
  given(:other_user) { create :user }
  given(:admin) { create :user, :admin }
  given(:question) { create :question, user: user }

  scenario 'Signed in user creating\updating\deleting question' do
    sing_in_user user
    expect(page).to have_content 'Signed in successfully.'

    new_question
    expect(page).to have_content 'Question successfully created!'

    visit root_path
    edit_question
    expect(page).to have_content 'Question successfully edited!'

    visit root_path
    click_on 'Delete'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content 'Question successfully deleted!'
  end

  scenario 'User try to edit or delete not his question' do
    sing_in_user other_user
    visit edit_question_path(question)
    expect(page).to have_content 'You are not authorized to perform this action!'
  end

  scenario 'Admin try to edit or delete not his question' do
    sing_in_user admin
    visit edit_question_path(question)
    expect(page).to have_content 'Editing question'
  end
end
