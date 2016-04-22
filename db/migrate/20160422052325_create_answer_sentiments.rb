class CreateAnswerSentiments < ActiveRecord::Migration
  def change
    create_table :answer_sentiments do |t|
      t.references :answer, index: true, foreign_key: true
      t.references :sentiment, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
