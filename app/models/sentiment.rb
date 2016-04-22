# == Schema Information
#
# Table name: sentiments
#
#  id   :integer          not null, primary key
#  name :string
#

class Sentiment < ActiveRecord::Base
  has_many :answers
end
