# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#

class Category < ActiveRecord::Base
  belongs_to :question
  has_many :answer_categories
  has_many :answers, through: :answer_categories
end
