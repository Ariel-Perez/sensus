class CreateStudentSurveyFilterValues < ActiveRecord::Migration
  def change
    create_table :student_survey_filter_values do |t|
      t.references :filter_value, index: true, foreign_key: true
      t.references :survey, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
