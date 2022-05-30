class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :body
      t.timestamps
      t.references :question, index: true
      t.references :user, index: true
    end
  end
end
