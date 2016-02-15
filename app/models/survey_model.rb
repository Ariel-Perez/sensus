class SurveyModel < ActiveRecord::Base
  belongs_to :user
  has_many :surveys
  has_many :questions
end
