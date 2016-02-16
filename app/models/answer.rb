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
