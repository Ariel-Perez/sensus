# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#  student_id  :integer
#  survey_id   :integer
#

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
