class SurveysController < ApplicationController
  before_filter :set_survey, :only => [:show, :update, :delete, :training]

  def index
    @surveys = Survey.all
  end

  def show
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.import(survey_params, params[:survey][:file])
    redirect_to survey_models_path
  end

  def training
    @model = SurveyModel.find(@survey.survey_model_id)
    @questions = Question.where(survey_model_id: @model.id).order(:index)

    @answers = Answer.where(survey_id: @survey.id).where.not(id: current_user.answers.pluck(:id))
  end

  private
    def survey_params
      params.require(:survey).permit(:name, :user_id, :survey_model_id)
    end

    def set_survey
      @survey = Survey.find(params[:id] || params[:survey_id])
    end
end
