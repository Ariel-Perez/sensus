class RemoveSurveyModelStudentIdentifier < ActiveRecord::Migration
  def change
    remove_column :survey_models, :student_identifier
  end
end
