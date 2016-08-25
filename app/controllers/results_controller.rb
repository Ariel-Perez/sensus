class ResultsController < ApplicationController
  def index
    @surveys = Survey.display
  end
end
