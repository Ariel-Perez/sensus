# == Schema Information
#
# Table name: processed_answers
#
#  id             :integer          not null, primary key
#  stemmed_text   :string
#  unstemmed_text :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  answer_id      :integer
#  original_text  :string
#

class ProcessedAnswer < ActiveRecord::Base
  validates :answer_id,  presence: true

  belongs_to :answer
end
