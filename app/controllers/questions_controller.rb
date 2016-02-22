class QuestionsController < ApplicationController
  before_filter :set_question, :only => [:show, :update, :delete, :answers, :categories]

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

    if params.has_key? :filter
      if params[:filter].has_key? :unseen
        @answers = @answers.where.not(id: current_user.answers)
      end

      if params[:filter].has_key? :notempty
        @answers = @answers.where.not(text: "")
      end
    end

    if params.has_key? :limit
      @answers = @answers.limit(params[:limit])
    end

    if params.has_key? :shuffle
      @answers = @answers.order("RANDOM()")
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answers }
    end
  end

  def categories
    @categories = Category.where(question_id: @question.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @categories }
    end
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
