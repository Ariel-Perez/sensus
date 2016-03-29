class CreateProcessedAnswer < ActiveRecord::Migration
  def change
    create_table :processed_answers do |t|
      t.string :stemmed_text
      t.string :unstemmed_text

      t.timestamps null: false
    end

    add_reference :processed_answers, :answer, index: true
    add_foreign_key :processed_answers, :answers
  end
end
