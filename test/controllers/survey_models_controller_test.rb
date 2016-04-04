# == Schema Information
#
# Table name: survey_models
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  user_id            :integer
#  student_identifier :integer          default(0)
#

require 'test_helper'

class SurveyModelsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
