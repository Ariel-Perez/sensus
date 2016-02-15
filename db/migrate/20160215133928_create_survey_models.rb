class CreateSurveyModels < ActiveRecord::Migration
  def change
    create_table :survey_models do |t|
      t.string :name

      t.timestamps null: false
    end
    add_reference :surveys, :survey_model, index: true
    add_foreign_key :surveys, :survey_models

    add_reference :survey_models, :user, index: true
    add_foreign_key :survey_models, :users
  end
end
