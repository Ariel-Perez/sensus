# == Schema Information
#
# Table name: surveys
#
#  id              :integer          not null, primary key
#  name            :string
#  path            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  survey_model_id :integer
#

require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
