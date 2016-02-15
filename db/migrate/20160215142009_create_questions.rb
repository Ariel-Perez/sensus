class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :index
      t.string :label
      t.string :description

      t.timestamps null: false
    end
    add_reference :questions, :survey_model, index: true
    add_foreign_key :questions, :survey_models
  end
end
