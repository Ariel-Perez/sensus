# == Schema Information
#
# Table name: student_survey_filter_values
#
#  id              :integer          not null, primary key
#  filter_value_id :integer
#  survey_id       :integer
#  student_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class StudentSurveyFilterValue < ActiveRecord::Base
  belongs_to :filter_value
  belongs_to :survey
  belongs_to :student
end
