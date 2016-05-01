# == Schema Information
#
# Table name: question_relationships
#
#  question_id             :integer
#  close_ended_question_id :integer
#  name                    :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class QuestionRelationship < ActiveRecord::Base
  validates :question_id,  presence: true
  validates :close_ended_question_id,  presence: true
  validates :name, presence: true

  belongs_to :question
  belongs_to :close_ended_question
end
