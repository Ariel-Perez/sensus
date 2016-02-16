class CreateAnswerCategories < ActiveRecord::Migration
  def change
    create_table :answer_categories do |t|

      t.timestamps null: false
    end

    add_reference :answer_categories, :user, index: true
    add_foreign_key :answer_categories, :users

    add_reference :answer_categories, :answer, index: true
    add_foreign_key :answer_categories, :answers

    add_reference :answer_categories, :category, index: true
    add_foreign_key :answer_categories, :categories
  end
end
