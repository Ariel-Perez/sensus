# == Schema Information
#
# Table name: answer_sentiments
#
#  id           :integer          not null, primary key
#  answer_id    :integer
#  sentiment_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class AnswerSentiment < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user
  belongs_to :sentiment
end
