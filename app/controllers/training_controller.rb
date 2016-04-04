class TrainingController < ApplicationController
  def index
    @surveys = Survey.all
  end
end
