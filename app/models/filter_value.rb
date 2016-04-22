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

class FilterValue < ActiveRecord::Base
  belongs_to :filter
end
