class ProcessedAnswer < ActiveRecord::Base
  validates :answer_id,  presence: true

  belongs_to :answer
end
