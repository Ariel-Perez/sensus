# == Schema Information
#
# Table name: close_ended_answers
#
#  id                      :integer          not null, primary key
#  student_id              :integer
#  close_ended_question_id :integer
#  survey_id               :integer
#  option_id               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class CloseEndedAnswer < ActiveRecord::Base
  validates :student_id,  presence: true
  validates :close_ended_question_id,  presence: true
  validates :survey_id,  presence: true

  belongs_to :student
  belongs_to :close_ended_question
  belongs_to :survey
end
