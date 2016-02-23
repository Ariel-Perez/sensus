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
    require 'fileutils'
    tmp = params[:survey][:file].tempfile
    filepath = File.join("public", params[:survey][:file].original_filename)
    FileUtils.cp tmp.path, filepath
    Resque.enqueue(SurveyLoader, survey_params, filepath)
    redirect_to survey_models_path
  end

  def training
    @model = SurveyModel.find(@survey.survey_model_id)
    @questions = Question.where(survey_model_id: @model.id).order(:index)
  end

  private
    def survey_params
      params.require(:survey).permit(:name, :user_id, :survey_model_id)
    end

    def set_survey
      @survey = Survey.find(params[:id] || params[:survey_id])
    end
end
