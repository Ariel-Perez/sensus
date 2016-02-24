# == Schema Information
#
# Table name: answer_categories
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  answer_id   :integer
#  category_id :integer
#

class AnswerCategory < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :answer

  delegate :survey, :to => :answer, :allow_nil => false
  delegate :question, :to => :answer, :allow_nil => false
end
