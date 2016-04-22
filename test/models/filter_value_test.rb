# == Schema Information
#
# Table name: filter_values
#
#  id         :integer          not null, primary key
#  value      :string
#  filter_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FilterValueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
