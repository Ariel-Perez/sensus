# == Schema Information
#
# Table name: survey_models
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class SurveyModelsController < ApplicationController
  before_filter :set_survey_model, :only => [:show, :update, :delete, :edit]

  def index
    @models = SurveyModel.all
  end

  def edit
    @question = Question.new
  end

  def show
    @survey = Survey.new
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
