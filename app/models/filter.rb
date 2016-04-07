class Filter < ActiveRecord::Base
  belongs_to :survey_model
  has_many :filter_values
end
