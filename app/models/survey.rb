# == Schema Information
#
# Table name: surveys
#
#  id              :integer          not null, primary key
#  name            :string
#  path            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  survey_model_id :integer
#

class Survey < ActiveRecord::Base
  validates :name,  presence: true
  validates :path,  presence: true
  validates :user_id,  presence: true
  validates :survey_model_id,  presence: true

  belongs_to :user
  belongs_to :survey_model
  has_many :answers
  has_many :answer_categories, through: :answers

  scope :display, -> { where(display: true) }

  def questions
    survey_model.questions
  end
end
