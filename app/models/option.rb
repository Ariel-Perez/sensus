# == Schema Information
#
# Table name: options
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Option < ActiveRecord::Base
  validates :name,  presence: true

  has_and_belongs_to_many :close_ended_questions
end
