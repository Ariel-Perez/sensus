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
    stopwords = Set.new ['de', 'la', 'que', 'el', 'en', 'y', 'a', 'los',
      'del', 'se', 'las', 'por', 'un', 'para', 'con', 'no', 'una', 's',
      'al', 'lo', 'como', 'más', 'pero', 'sus', 'le', 'ya', 'o', 'este',
      'sí', 'porque', 'esta', 'entre', 'cuando', 'muy', 'sin', 'sobre',
      'también', 'me', 'hasta', 'hay', 'donde', 'quien', 'desde', 'todo',
      'nos', 'durante', 'todos', 'uno', 'les', 'ni', 'contra', 'otros',
      'ese', 'eso', 'ante', 'ellos', 'e', 'esto', 'mí', 'antes', 'algunos',
      'qué', 'unos', 'yo', 'otro', 'otras', 'otra', 'él', 'tanto', 'esa',
      'estos', 'mucho', 'quienes', 'nada', 'muchos', 'cual', 'poco', 'ella',
      'estar', 'estas', 'algunas', 'algo', 'nosotros', 'mi', 'mis', 'tú', 'te',
      'ti', 'tu', 'tus', 'ellas', 'nosotras', 'vosostros', 'vosostras', 'os',
      'mío', 'mía', 'míos', 'mías', 'tuyo', 'tuya', 'tuyos', 'tuyas', 'suyo',
      'suya', 'suyos', 'suyas', 'nuestro', 'nuestra', 'nuestros', 'nuestras',
      'vuestro', 'vuestra', 'vuestros', 'vuestras', 'esos', 'esas', 'estoy',
      'estás', 'está', 'estamos', 'estáis', 'están', 'esté', 'estés', 'estemos',
      'estéis', 'estén', 'estaré', 'estarás', 'estará', 'estaremos', 'estaréis',
      'estarán', 'estaría', 'estarías', 'estaríamos', 'estaríais', 'estarían',
      'estaba', 'estabas', 'estábamos', 'estabais', 'estaban', 'estuve',
      'estuviste', 'estuvo', 'estuvimos', 'estuvisteis', 'estuvieron',
      'estuviera', 'estuvieras', 'estuviéramos', 'estuvierais', 'estuvieran',
      'estuviese', 'estuvieses', 'estuviésemos', 'estuvieseis', 'estuviesen',
      'estando', 'estado', 'estada', 'estados', 'estadas', 'estad', 'he', 'has',
      'ha', 'hemos', 'habéis', 'han', 'haya', 'hayas', 'hayamos', 'hayáis',
      'hayan', 'habré', 'habrás', 'habrá', 'habremos', 'habréis', 'habrán',
      'habría', 'habrías', 'habríamos', 'habríais', 'habrían', 'había', 'habías',
      'habíamos', 'habíais', 'habían', 'hube', 'hubiste', 'hubo', 'hubimos',
      'hubisteis', 'hubieron', 'hubiera', 'hubieras', 'hubiéramos', 'hubierais',
      'hubieran', 'hubiese', 'hubieses', 'hubiésemos', 'hubieseis', 'hubiesen',
      'habiendo', 'habido', 'habida', 'habidos', 'habidas', 'soy', 'eres', 'es',
      'somos', 'sois', 'son', 'sea', 'seas', 'seamos', 'seáis', 'sean', 'seré',
      'serás', 'será', 'seremos', 'seréis', 'serán', 'sería', 'serías', 'seríamos',
      'seríais', 'serían', 'era', 'eras', 'éramos', 'erais', 'eran', 'fui', 'fuiste',
      'fue', 'fuimos', 'fuisteis', 'fueron', 'fuera', 'fueras', 'fuéramos', 'fuerais',
      'fueran', 'fuese', 'fueses', 'fuésemos', 'fueseis', 'fuesen', 'sintiendo', 'sentido',
      'sentida', 'sentidos', 'sentidas', 'siente', 'sentid', 'tengo', 'tienes', 'tiene',
      'tenemos', 'tenéis', 'tienen', 'tenga', 'tengas', 'tengamos', 'tengáis', 'tengan',
      'tendré', 'tendrás', 'tendrá', 'tendremos', 'tendréis', 'tendrán', 'tendría',
      'tendrías', 'tendríamos', 'tendríais', 'tendrían', 'tenía', 'tenías', 'teníamos',
      'teníais', 'tenían', 'tuve', 'tuviste', 'tuvo', 'tuvimos', 'tuvisteis', 'tuvieron',
      'tuviera', 'tuvieras', 'tuviéramos', 'tuvierais', 'tuvieran', 'tuviese', 'tuvieses',
      'tuviésemos', 'tuvieseis', 'tuviesen', 'teniendo', 'tenido', 'tenida', 'tenidos',
      'tenidas', 'tened']

    answers.each do |answer|
      words = answer.text.downcase.split(/\W+/)
      words.each do |word|
        unless stopwords.include? word
          word_frequencies[word] += 1
        end
      end
    end

    # most_common_answers = answers.group_by { |r| r["count"] }
    #   .sort_by  { |k, v| -k }
    #   .first(2)
    #   .map(&:last)
    #   .flatten

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
