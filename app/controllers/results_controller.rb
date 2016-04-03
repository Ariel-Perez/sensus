class ResultsController < ApplicationController
  def index
    @surveys = Survey.where(id: Answer.pluck(:survey_id))
  end
end
