class QuestionsController < ApplicationController
  before_filter :set_question, :only => [:show, :update, :delete]

  def show
  end

  def create
    @question = Question.new(question_params)
    @question.save
    redirect_to @question.survey_model
  end

  def update
  end

  def delete
  end

  private
    def question_params
      params.require(:question).permit(:index, :label, :description, :survey_model_id)
    end

    def set_question
      @question = Question.find(params[:id])
    end
end
