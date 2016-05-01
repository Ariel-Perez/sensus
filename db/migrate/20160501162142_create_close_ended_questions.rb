class CreateCloseEndedQuestions < ActiveRecord::Migration
  def change
    create_table :close_ended_questions do |t|
      t.references :survey_model, index: true, foreign_key: true
      t.integer :index
      t.string :label
      t.string :description

      t.timestamps null: false
    end
  end
end
