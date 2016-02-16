class Question < ActiveRecord::Base
  validates :index,  presence: true
  validates :label,  presence: true
  validates :description,  presence: true
  validates :survey_model_id,  presence: true

  belongs_to :survey_model
  has_many :answers
  has_many :categories
end
