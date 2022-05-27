class AddQuestionIdToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_reference :answers, :question, index: true
  end
end
