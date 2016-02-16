class Category < ActiveRecord::Base
  belongs_to :question
  has_many :answer_categories
  has_many :answers, through: :answer_categories
end
