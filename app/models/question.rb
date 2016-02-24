# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  index           :integer
#  label           :string
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  survey_model_id :integer
#

class Question < ActiveRecord::Base
  validates :index,  presence: true
  validates :label,  presence: true
  validates :description,  presence: true
  validates :survey_model_id,  presence: true

  belongs_to :survey_model
  has_many :answers
  has_many :categories
end
