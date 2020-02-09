class AddAttemptToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :answers, :attempt, foreign_key: true
  end
end
