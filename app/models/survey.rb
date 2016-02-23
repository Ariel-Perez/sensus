class Survey < ActiveRecord::Base
  validates :name,  presence: true
  validates :path,  presence: true
  validates :user_id,  presence: true
  validates :survey_model_id,  presence: true

  belongs_to :user
  belongs_to :survey_model
  has_many :answers
  has_many :answer_categories, through: :answers
end
