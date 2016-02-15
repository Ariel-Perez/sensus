class SurveysController < ApplicationController
  before_filter :set_survey, :only => [:show, :update, :delete]

  def index
    @surveys = Survey.all
  end

  def show
  end

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      flash[:success] = "Encuesta cargada con éxito"
      redirect_to @survey
    else
      render 'new'
    end
  end

  private
    def survey_model_params
      params.require(:survey_model).permit(:name, :user_id)
    end

    def set_survey
      @survey = Survey.find(params[:id])
    end
end
