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

class Filter < ActiveRecord::Base
  belongs_to :survey_model
  has_many :filter_values
end
