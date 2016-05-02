# == Schema Information
#
# Table name: surveys
#
#  id              :integer          not null, primary key
#  name            :string
#  path            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  survey_model_id :integer
#

class SurveysController < ApplicationController
  before_filter :set_survey, :only => [:show, :update, :delete, :training, :results, :filters, :upload_filters]

  def index
    @surveys = Survey.all
  end

  def show
    @model = @survey.survey_model
  end

  def new
    @survey = Survey.new
    @survey_models = SurveyModel.all
  end

  def create
    require 'fileutils'
    tmp = params[:survey][:file].tempfile
    filepath = File.join("public", params[:survey][:file].original_filename)
    FileUtils.cp tmp.path, filepath
    Resque.enqueue(SurveyLoader, survey_params, filepath)
    flash[:success] = "La encuesta está siendo procesada"
    redirect_to survey_models_path
  end

  def training
    @model = SurveyModel.find(@survey.survey_model_id)
    @questions = Question.where(survey_model_id: @model.id).order(:index)
  end

  def results
    @model = SurveyModel.find(@survey.survey_model_id)
  end

  def filters
  end

  def upload_filters
    require 'fileutils'
    tmp = params[:file].tempfile
    filepath = File.join("public", params[:file].original_filename)
    FileUtils.cp tmp.path, filepath
    Resque.enqueue(FilterLoader, @survey.id, filepath)
    flash[:success] = "Cargando los filtros a la base de datos"

    redirect_to @survey
  end

  def upload_close_ended_answers
    require 'fileutils'
    tmp = params[:file].tempfile
    filepath = File.join("public", params[:file].original_filename)
    FileUtils.cp tmp.path, filepath
    Resque.enqueue(CloseEndedLoader, @survey.id, filepath)
    flash[:success] = "Cargando las respuestas cerradas a la base de datos (#{params[:file].original_filename})"
    redirect_to survey_path(@survey)
  end

  private
    def survey_params
      params.require(:survey).permit(:name, :user_id, :survey_model_id)
    end

    def set_survey
      @survey = Survey.find(params[:id] || params[:survey_id])
    end
end
