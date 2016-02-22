class AddStudentColumnToSurveyModel < ActiveRecord::Migration
  def change
    add_column :survey_models, :student_identifier, :integer, default: 0
  end
end
