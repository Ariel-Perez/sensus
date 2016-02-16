class QuestionsController < ApplicationController
  before_filter :set_question, :only => [:show, :update, :delete, :answers]

  def show
    @answers = Answer.where(question_id: @question.id)
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

  def answers
    @answers = Answer.where(question_id: @question.id)
  end

  private
    def question_params
      params.require(:question).permit(:index, :label, :description, :survey_model_id)
    end

    def filter_params
      if params[:filter]
        return params[:filter].permit(:user_id, :responded)
      end
    end

    def set_question
      @question = Question.find(params[:id] || params[:question_id])
    end
end
