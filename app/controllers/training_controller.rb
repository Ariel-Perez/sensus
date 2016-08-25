class TrainingController < ApplicationController
  def index
    @surveys = Survey.display
  end
end
