class CreateCloseEndedAnswers < ActiveRecord::Migration
  def change
    create_table :close_ended_answers do |t|
      t.references :student, index: true, foreign_key: true
      t.references :close_ended_question, index: true, foreign_key: true
      t.references :survey, index: true, foreign_key: true
      t.references :option, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
