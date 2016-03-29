# == Schema Information
#
# Table name: survey_models
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class SurveyModel < ActiveRecord::Base
  belongs_to :user
  has_many :surveys
  has_many :questions
end
