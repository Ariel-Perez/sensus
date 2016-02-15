class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :text

      t.timestamps null: false
    end

    add_reference :answers, :question, index: true
    add_foreign_key :answers, :questions

    add_reference :answers, :student, index: true
    add_foreign_key :answers, :students

    add_reference :answers, :survey, index: true
    add_foreign_key :answers, :surveys
  end
end
