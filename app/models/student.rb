class Student < ActiveRecord::Base
  validates :identifier,  presence: true

  has_many :answers
end
