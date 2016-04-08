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

class Question < ActiveRecord::Base
  include HashHelper

  validates :index,  presence: true
  validates :label,  presence: true
  validates :description,  presence: true
  validates :survey_model_id,  presence: true

  belongs_to :survey_model
  has_many :answers
  has_many :categories

  def ngrams(survey, n, filter, category)
    filtered_answers = filter_answers(answers, filter, category)
    proc_answers = ProcessedAnswer.where(answer_id: filtered_answers.pluck(:id))

    stem_frequencies = Hash.new(0)
    stem_origins = Hash.new {|hash,key| hash[key] = Hash.new(0)}

    def build_key(stems)
      key_parts = stems.sort
      key = key_parts.join(' ')
    end

    max_delta = (n - 1) * 2
    proc_answers.each do |proc_answer|
      unless proc_answer.stemmed_text == "0"
        stems = proc_answer.stemmed_text.downcase.split(' ')
        origins = proc_answer.unstemmed_text.downcase.split(' ')

        length = stems.length
        indices = (0..n - 1).to_a

        while indices[0] <= stems.length - n do
          ngram_stems = indices.map { |index| stems[index] }
          ngram_origins = indices.map { |index| origins[index] }

          key = build_key(ngram_stems)
          value = ngram_origins.join(' ')

          stem_frequencies[key] += 1
          stem_origins[key][value] += 1

          index_iterator = n - 1
          indices[index_iterator] += 1

          while index_iterator > 0 and indices[index_iterator] > length - n + index_iterator
            indices[index_iterator - 1] += 1
            index_iterator -= 1
          end
          (index_iterator + 1..n - 1).each do |i|
            indices[i] = indices[i - 1] + 1
          end
        end
      end
    end

    n = 100
    wordcloud_stems = HashHelper.get_n_largest(stem_frequencies, n)

    word_cloud_ready_words = []
    wordcloud_stems.each do |stem|
      word_cloud_ready_words << {text: stem_origins[stem].max_by{|k,v| v}[0], size: stem_frequencies[stem]}
    end

    result = {
      wordcloud: word_cloud_ready_words,
      stem_frequencies: stem_frequencies}
  end

  private
    def filter_answers(answers_to_filter, filter, category)
      filtered_answers = answers_to_filter
      if filter
        query_values = filter.split(',')
        query_values.each do |value_id|
          unless value_id == "0"
            valid_students = Student.where(id: StudentSurveyFilterValue.where(filter_value_id: value_id).uniq.pluck(:student_id))
            filtered_answers = filtered_answers.where(student_id: valid_students.pluck(:id))
          end
        end
      end
      if category and category != "0"
        filtered_answers = filtered_answers.where(id: AnswerCategory.where(category_id: category).uniq.pluck(:answer_id))
      end

      return filtered_answers
    end
end
