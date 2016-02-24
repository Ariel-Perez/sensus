# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  index           :integer
#  label           :string
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  survey_model_id :integer
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
