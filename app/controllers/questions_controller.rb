# == Schema Information
#
# Table name: questions
#
#  id              :integer          not null, primary key
#  index           :integer
#  label           :string
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  survey_model_id :integer
#

class QuestionsController < ApplicationController
  before_filter :set_question, :only => [:show, :update, :delete, :answers, :categories, :download, :wordcloud]

  def show
    @categories = @question.categories
    category_ids = @categories.pluck(:id)

    @total_answers = Answer.where(question_id: @question.id).count
    @categorized_answers = AnswerCategory.where(category_id: category_ids).group(:answer_id).count.count
    @answers_per_category = AnswerCategory.where(category_id: category_ids).group(:category_id).count
    @answers_per_category.default = 0


    @categories = @categories.sort_by {|category| -@answers_per_category[category.id]}
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

  def download
    column_separator = ","
    line_separator = "\n"

    categories = @question.categories
    header = (["Sample"] + categories.pluck(:name)).join(column_separator)

    answer_ids = AnswerCategory.where(
      category_id: categories.pluck(:id)).uniq.pluck(:answer_id)
    answers = Answer.where(id: answer_ids)
    
    category_column_map = {}
    categories.each_with_index do |c, i|
      category_column_map[c.id] = i
    end

    rows = []
    answers.each do |answer|
      answer_category_ids = AnswerCategory.where(answer_id: answer.id).uniq.pluck(:category_id)
      category_data = ["0"] * categories.length
      answer_category_ids.each do |c|
        category_data[category_column_map[c]] = "1"
      end

      rows.push(([answer.student.identifier] + [category_data]).join(column_separator))
    end

    data = ([header] + rows).join(line_separator)
    send_data(data, :filename => @question.label + ".csv")
  end

  def wordcloud
    answers = Answer.where(question_id: @question.id)
    word_frequencies = {}
    word_frequencies.default = 0

    require 'set'
    stopwords = Set.new [
      'el', 'la', 'que', 'de', 'por', 'los', 'las', 'y', 
      'porque', 'para', 'en', 'mi', 'porque', 'es', 'entre', 
      'son', 'hay', 'muy', 'se', 'no', 'me', 'lo', 'asi', 'a',
      'como', 'del', 'sin']

    answers.each do |answer|
      words = answer.text.downcase.split(/\W+/)
      words.each do |word|
        unless stopwords.include? word
          word_frequencies[word] += 1
        end
      end
    end

    word_cloud_ready_words = []
    word_frequencies.each do |word, frequency|
      unless stopwords.include? word
        word_cloud_ready_words << {text: word, size: frequency}
      end
    end

    gon.word_frequencies = word_cloud_ready_words
    gon.highest_frequency = word_frequencies.values.max
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
