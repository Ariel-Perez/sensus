class SurveyModelsController < ApplicationController
  before_filter :set_survey_model, :only => [:show, :update, :delete]

  def index
    @models = SurveyModel.all
  end

  def show
    @question = Question.new
  end

  def new
    @model = SurveyModel.new
  end

  def create
    @model = SurveyModel.new(survey_model_params)
    if @model.save
      flash[:success] = "Modelo creado con éxito"
      redirect_to @model
    else
      render 'new'
    end
  end

  private
    def survey_model_params
      params.require(:survey_model).permit(:name, :user_id)
    end

    def set_survey_model
      @model = SurveyModel.find(params[:id])
    end
end
