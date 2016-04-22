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

require 'test_helper'

class AnswerSentimentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
