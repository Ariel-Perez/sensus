# == Schema Information
#
# Table name: sentiments
#
#  id   :integer          not null, primary key
#  name :string
#

class Sentiment < ActiveRecord::Base
  has_many :answer_sentiments
  has_many :answers, through: :answer_sentiments
end
