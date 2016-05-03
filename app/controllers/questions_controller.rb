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
  before_filter :set_question, :except => [:create]
  before_filter :set_survey, :except => [:create]

  # def charts
  #   @filters = @question.survey_model.filters
  #   @categories = @question.categories.order(:name)
  #   @answers = Answer.where(question_id: @question.id)
  #   if @survey
  #     @answers = @answers.where(survey_id: @survey.id)
  #   end

  #   @relationships = @question.question_relationships.includes(:close_ended_question).includes(close_ended_question: :options)
  #   @answers = filter_answers(@answers)

  #   @sentiments = Sentiment.all

  #   gon.remove_ngrams = params[:remove_ngrams]
  #   gon.category_names = @categories.pluck(:name)

  #   data = @answers.joins(:answer_sentiments, :answer_categories).group(:sentiment_id, :category_id).count()
  #   datasets = @sentiments.map { |sentiment| {
  #     data: @categories.map { |category| data[[sentiment.id, category.id]].to_i },
  #     name: sentiment.name } }

  #   gon.datasets = datasets
  #   gon.relationships = params[:relationships]
  # end

  def charts
    @filters = @question.survey_model.filters
    @categories = @question.categories.order(:name)
    @answers = Answer.where(question_id: @question.id)
    if @survey
      @answers = @answers.where(survey_id: @survey.id)
    end

    @relationships = @question.question_relationships.includes(:close_ended_question).includes(close_ended_question: :options)
    @answers = filter_answers(@answers)

    gon.remove_ngrams = params[:remove_ngrams]
    gon.category_names = @categories.pluck(:name)

    data = @answers.joins(:answer_categories).group(:category_id).count
    datasets = @categories.map { |category| data[category.id].to_i }

    gon.datasets = datasets
    gon.relationships = params[:relationships]
  end

  def sentiment
    @filters = @question.survey_model.filters
    @categories = @question.categories.order(:name)
    @answers = Answer.where(question_id: @question.id)
    if @survey
      @answers = @answers.where(survey_id: @survey.id)
    end

    @relationships = @question.question_relationships.includes(:close_ended_question).includes(close_ended_question: :options)
    @answers = filter_answers(@answers)

    @sentiments = Sentiment.order(name: :desc)

    gon.remove_ngrams = params[:remove_ngrams]
    gon.sentiment_names = @sentiments.pluck(:name)

    data = @answers.joins(:answer_sentiments).group(:sentiment_id).count
    datasets = @sentiments.map { |sentiment| data[sentiment.id].to_i }

    gon.datasets = datasets
    gon.relationships = params[:relationships]
  end

  def create
    @question = Question.new(question_params)
    @question.save
    redirect_to @question.survey_model
  end

  def upload_stems
    require 'fileutils'
    tmp = params[:file].tempfile
    filepath = File.join("public", params[:file].original_filename)
    FileUtils.cp tmp.path, filepath
    Resque.enqueue(StemLoader, filepath)
    flash[:success] = "Cargando los textos procesados a la base de datos (#{params[:file].original_filename}"

    redirect_to @survey ? survey_question_path(@survey, @question) : question_path(@question)
  end

  def upload_classifications
    require 'fileutils'
    tmp = params[:file].tempfile
    filepath = File.join("public", params[:file].original_filename)
    FileUtils.cp tmp.path, filepath
    Resque.enqueue(ResultLoader, @question.id, filepath)
    flash[:success] = "Cargando las clasificaciones a la base de datos (#{params[:file].original_filename}"
    redirect_to @survey ? survey_question_path(@survey, @question) : question_path(@question)
  end

  def upload_sentiments
    require 'fileutils'
    tmp = params[:file].tempfile
    filepath = File.join("public", params[:file].original_filename)
    FileUtils.cp tmp.path, filepath
    Resque.enqueue(SentimentLoader, filepath)
    flash[:success] = "Cargando los sentimientos a la base de datos (#{params[:file].original_filename}"
    redirect_to @survey ? survey_question_path(@survey, @question) : question_path(@question)
  end

  def download_answers
    column_separator = ","
    line_separator = "\n"

    categories = @question.categories
    header = ["id", "student_id"].join(column_separator)
    answers = Answer.includes(:student).where(question_id: @question.id)

    if @survey
      answers = answers.where(survey_id: @survey.id)
    end

    rows = answers.map {|answer| [answer.id, answer.student.identifier, "\"#{answer.text}\""].join(column_separator)}

    data = ([header] + rows).join(line_separator)
    send_data(data, :filename => @question.label + ".csv")
  end

  def download_classifications
    column_separator = ","
    line_separator = "\n"

    categories = @question.categories
    header = (["Sample"] + categories.pluck(:name)).join(column_separator)

    answer_categories = AnswerCategory.where(category_id: categories.pluck(:id))
    answer_ids = answer_categories.uniq.pluck(:answer_id)
    answers = Answer.where(id: answer_ids)
    if @survey
      answers = answers.where(survey_id: @survey.id)
    end
    answers = filter_answers(answers)

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

  def unigrams
    @filters = @question.survey_model.filters
    @categories = @question.categories.order(:name)
    @relationships = @question.question_relationships.includes(:close_ended_question).includes(close_ended_question: :options)
    result = @question.unigrams(
      @survey,
      params[:filter],
      params[:category],
      params[:relationships],
      params[:remove_ngrams])

    @n = 1
    gon.n = @n

    gon.wordcloud_keys = result[:wordcloud_keys]
    gon.wordcloud_data = result[:wordcloud_data]

    gon.filter = params[:filter]
    gon.category = params[:category]
    gon.relationships = params[:relationships]
    gon.remove_ngrams = params[:remove_ngrams]
    render :wordcloud
  end

  def bigrams
    @filters = @question.survey_model.filters
    @categories = @question.categories.order(:name)
    @relationships = @question.question_relationships.includes(:close_ended_question).includes(close_ended_question: :options)
    result = @question.bigrams(
      @survey,
      params[:filter],
      params[:category],
      params[:relationships],
      params[:remove_ngrams])

    @n = 2
    gon.n = @n

    gon.wordcloud_keys = result[:wordcloud_keys]
    gon.wordcloud_data = result[:wordcloud_data]

    gon.filter = params[:filter]
    gon.category = params[:category]
    gon.relationships = params[:relationships]
    gon.remove_ngrams = params[:remove_ngrams]
    render :wordcloud
  end

  def trigrams
    @filters = @question.survey_model.filters
    @categories = @question.categories.order(:name)
    @relationships = @question.question_relationships.includes(:close_ended_question).includes(close_ended_question: :options)
    result = @question.trigrams(
      @survey,
      params[:filter],
      params[:category],
      params[:relationships],
      params[:remove_ngrams])

    @n = 3
    gon.n = @n

    gon.wordcloud_keys = result[:wordcloud_keys]
    gon.wordcloud_data = result[:wordcloud_data]

    gon.filter = params[:filter]
    gon.category = params[:category]
    gon.relationships = params[:relationships]
    gon.remove_ngrams = params[:remove_ngrams]
    render :wordcloud
  end

  def answers
    @answers = @question.answers

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

    def filter_answers(answers)
      if params[:filter] and params[:filter] != "0"
        filters = Filter.where(survey_model_id: @question.survey_model.id)
        query_values = params[:filter].split(',')

        query_values.each do |value_id|
          unless value_id == "0"
            valid_students = Student.where(id: StudentSurveyFilterValue.where(filter_value_id: value_id).uniq.pluck(:student_id))
            answers = answers.where(student_id: valid_students.pluck(:id))
          end
        end

        gon.filter = params[:filter]
      end
      if params[:category] and params[:category] != "0"
        answers = answers.where(id: AnswerCategory.where(category_id: params[:category]).uniq.pluck(:answer_id))
        gon.category = params[:category]
      end

      if params[:relationships] and params[:relationships] != "0"
        options = params[:relationships].split(',')
        options.each_with_index do |option_id, index|
          unless option_id == "0"
            closed_answers = CloseEndedAnswer.where(
              option_id: option_id,
              close_ended_question_id: @question.close_ended_questions[index])

            valid_students = closed_answers.pluck(:student_id)
            answers = answers.where(student_id: valid_students)
          end
        end
      end

      return answers
    end

    def filter_params
      if params[:filter]
        return params[:filter].permit(:user_id, :responded)
      end
    end

    def set_question
      @question = Question.find(params[:id] || params[:question_id])
    end

    def set_survey
      @survey = params[:survey_id] ? Survey.find(params[:survey_id]) : nil
    end
end
