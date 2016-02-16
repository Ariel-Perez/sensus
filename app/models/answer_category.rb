class AnswerCategory < ActiveRecord::Base
  belongs_to :answer
  belongs_to :category
  belongs_to :user
end
