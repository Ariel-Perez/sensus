# == Schema Information
#
# Table name: close_ended_questions
#
#  id              :integer          not null, primary key
#  survey_model_id :integer
#  index           :integer
#  label           :string
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class CloseEndedQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
