# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  identifier :string
#  meta       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ActiveRecord::Base
  validates :identifier,  presence: true

  has_many :answers
end
