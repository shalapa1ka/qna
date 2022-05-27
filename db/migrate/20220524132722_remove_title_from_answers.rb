class RemoveTitleFromAnswers < ActiveRecord::Migration[7.0]
  def change
    remove_column :answers, :title
  end
end
