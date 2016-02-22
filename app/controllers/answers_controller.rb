class AnswersController < ApplicationController
  before_filter :set_answer, :only => [:show, :classify]

  def show
  end

  def classify
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer }
    end
  end

  private
    def set_answer
      @answer = Answer.find(params[:id] || params[:answer_id])
    end
end
