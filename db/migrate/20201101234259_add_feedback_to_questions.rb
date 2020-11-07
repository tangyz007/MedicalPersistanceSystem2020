class AddFeedbackToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :feedback, :text
  end
end
