# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :body
      t.timestamps
      t.references :user, index: true
    end
  end
end
