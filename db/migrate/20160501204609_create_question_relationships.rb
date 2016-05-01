class CreateQuestionRelationships < ActiveRecord::Migration
  def change
    create_table :question_relationships, id:false do |t|
      t.references :question, index: true, foreign_key: true
      t.references :close_ended_question, index: true, foreign_key: true
      t.text :name

      t.timestamps null: false
    end
  end
end
