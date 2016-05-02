# == Schema Information
#
# Table name: close_ended_answers
#
#  id                      :integer          not null, primary key
#  student_id              :integer
#  close_ended_question_id :integer
#  survey_id               :integer
#  option_id               :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'test_helper'

class CloseEndedAnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
