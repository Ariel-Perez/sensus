class AddOriginalTextToProcessedAnswer < ActiveRecord::Migration
  def up
    add_column :processed_answers, :original_text, :string

    proc_answers = ProcessedAnswer.includes(:answer)
    proc_answers.each do |proc_answer|
      proc_answer.original_text = proc_answer.answer.text
      proc_answer.save
    end
  end

  def down
    remove_column :processed_answers, :original_text
  end
end
