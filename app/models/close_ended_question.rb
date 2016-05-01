# == Schema Information
#
# Table name: close_ended_questions
#
#  id              :integer          not null, primary key
#  survey_model_id :integer
#  index           :integer
#  label           :string
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CloseEndedQuestion < ActiveRecord::Base
  validates :index,  presence: true
  validates :label,  presence: true
  validates :description,  presence: true
  validates :survey_model_id,  presence: true

  belongs_to :survey_model

  has_and_belongs_to_many :options

  has_many :question_relationships
  has_many :questions, through: :question_relationships
end
