class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps null: false
    end

    add_reference :categories, :question, index: true
    add_foreign_key :categories, :questions
  end
end
