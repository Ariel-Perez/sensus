# == Schema Information
#
# Table name: filters
#
#  id              :integer          not null, primary key
#  name            :string
#  survey_model_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class FilterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
