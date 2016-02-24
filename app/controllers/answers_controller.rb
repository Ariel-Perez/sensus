# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer
#  student_id  :integer
#  survey_id   :integer
#

class AnswersController < ApplicationController
  before_filter :set_answer, :only => [:show, :classify, :declassify]

  def show
  end

  def classify
    AnswerCategory.find_or_create_by(
      category_id: params[:category_id], 
      user_id: current_user.id,
      answer_id: @answer.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: "OK" }
    end
  end

  def declassify
    AnswerCategory.where(
      category_id: params[:category_id], 
      user_id: current_user.id,
      answer_id: @answer.id).destroy_all

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: "OK" }
    end
  end

  private
    def set_answer
      @answer = Answer.find(params[:id] || params[:answer_id])
    end
end
