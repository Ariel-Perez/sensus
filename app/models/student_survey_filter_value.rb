class StudentSurveyFilterValue < ActiveRecord::Base
  belongs_to :filter_value
  belongs_to :survey
  belongs_to :student
end
