# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#  student_id  :integer
#  survey_id   :integer
#

class Answer < ActiveRecord::Base
  validates :student_id,  presence: true
  validates :question_id,  presence: true
  validates :survey_id,  presence: true

  belongs_to :student
  belongs_to :survey
  belongs_to :question

  has_many :answer_categories
  has_many :categories, through: :answer_categories
end
