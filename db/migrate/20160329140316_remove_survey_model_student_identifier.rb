class RemoveSurveyModelStudentIdentifier < ActiveRecord::Migration
  def change
    remove_column :survey_models, :student_identifier, :integer, default: 0
  end
end
