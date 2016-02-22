class AnswerCategory < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :answer

  delegate :survey, :to => :answer, :allow_nil => false
  delegate :question, :to => :answer, :allow_nil => false
end
