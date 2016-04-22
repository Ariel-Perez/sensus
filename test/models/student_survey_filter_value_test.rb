# == Schema Information
#
# Table name: student_survey_filter_values
#
#  id              :integer          not null, primary key
#  filter_value_id :integer
#  survey_id       :integer
#  student_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class StudentSurveyFilterValueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
