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
require 'set'
class Question < ActiveRecord::Base
  include HashHelper

  validates :index,  presence: true
  validates :label,  presence: true
  validates :description,  presence: true
  validates :survey_model_id,  presence: true

  belongs_to :survey_model
  has_many :answers
  has_many :categories

  def next
    Question.where(survey_model_id: survey_model_id).where("index > ?", index).order(:index).first
  end

  def previous
    Question.where(survey_model_id: survey_model_id).where("index < ?", index).order(:index).last
  end

  def unigrams(survey, filter, category, remove_ngrams)
    skip_ngrams = hash_ngrams remove_ngrams
    skip_ngram_stems = Set.new
    n_samples = 3

    filtered_answers = filter_answers(answers, filter, category)
    proc_answers = ProcessedAnswer.where(answer_id: filtered_answers.pluck(:id)).includes(:answer)

    stem_frequencies = Hash.new(0)
    stem_origins = Hash.new {|hash,key| hash[key] = Hash.new(0)}
    sample_sentences = Hash.new {|hash,key| hash[key] = Array.new}

    proc_answers.each do |proc_answer|
      unless proc_answer.stemmed_text == "0"
        stems = proc_answer.stemmed_text.downcase.split(' ')
        origins = proc_answer.unstemmed_text.downcase.split(' ')

        stems.zip origins.each do |stem, origin|
          if skip_ngrams.include? origin
            skip_ngram_stems.add(stem)
            stem_frequencies.delete stem
            stem_origins.delete stem
            sample_sentences.delete stem
          elsif not skip_ngram_stems.include? stem
            stem_frequencies[stem] += 1
            stem_origins[stem][origin] += 1

            if sample_sentences[stem].length < n_samples
              sample_sentences[stem] << proc_answer.original_text
            end
          end
        end
      end
    end

    build_wordcloud_result(stem_frequencies, stem_origins, sample_sentences, 100)
  end

  def bigrams(survey, filter, category, remove_ngrams)
    skip_ngrams = hash_ngrams remove_ngrams
    skip_ngram_stems = Set.new
    n_samples = 3

    filtered_answers = filter_answers(answers, filter, category)
    proc_answers = ProcessedAnswer.where(answer_id: filtered_answers.pluck(:id)).includes(:answer)

    stem_frequencies = Hash.new(0)
    stem_origins = Hash.new {|hash,key| hash[key] = Hash.new(0)}
    sample_sentences = Hash.new {|hash,key| hash[key] = Array.new}


    def build_key(stem1, stem2)
      key_parts = [stem1, stem2].sort
      key = "#{key_parts[0]} #{key_parts[1]}"
    end

    max_delta = 2
    proc_answers.each do |proc_answer|
      unless proc_answer.stemmed_text == "0"
        stems = proc_answer.stemmed_text.downcase.split(' ')
        origins = proc_answer.unstemmed_text.downcase.split(' ')

        (0..stems.length - 1).each do |i|
          max_j = [stems.length - 1, i + max_delta].min
          (i + 1..max_j).each do |j|
            i_stem = stems[i]
            j_stem = stems[j]

            if i_stem == j_stem
              next
            end

            i_origin = origins[i]
            j_origin = origins[j]

            key = build_key(i_stem, j_stem)
            value = "#{i_origin} #{j_origin}"
            if skip_ngrams.include? value.split(' ').sort().join(' ')
              skip_ngram_stems.add key
              stem_frequencies.delete key
              stem_origins.delete key
              sample_sentences.delete key
            elsif not skip_ngram_stems.include? key
              stem_frequencies[key] += 1
              stem_origins[key][value] += 1

              if sample_sentences[key].length < n_samples
                sample_sentences[key] << proc_answer.original_text
              end
            end
          end
        end
      end
    end

    build_wordcloud_result(stem_frequencies, stem_origins, sample_sentences, 100)
  end

  def trigrams(survey, filter, category, remove_ngrams)
    skip_ngrams = hash_ngrams remove_ngrams
    skip_ngram_stems = Set.new
    n_samples = 3

    filtered_answers = filter_answers(answers, filter, category)
    proc_answers = ProcessedAnswer.where(answer_id: filtered_answers.pluck(:id)).includes(:answer)

    stem_frequencies = Hash.new(0)
    stem_origins = Hash.new {|hash,key| hash[key] = Hash.new(0)}
    sample_sentences = Hash.new {|hash,key| hash[key] = Array.new}

    def build_key(stem1, stem2, stem3)
      key_parts = [stem1, stem2, stem3].sort
      key = "#{key_parts[0]} #{key_parts[1]} #{key_parts[2]}"
    end

    max_delta = 4
    proc_answers.each do |proc_answer|
      unless proc_answer.stemmed_text == "0"
        stems = proc_answer.stemmed_text.downcase.split(' ')
        origins = proc_answer.unstemmed_text.downcase.split(' ')

        (0..stems.length - 1).each do |i|
          max_k = [stems.length - 1, i + max_delta].min
          (i + 1..max_k).each do |j|
            (j + 1..max_k).each do |k|
              i_stem = stems[i]
              j_stem = stems[j]
              k_stem = stems[k]

              if i_stem == j_stem or i_stem == k_stem or j_stem == k_stem
                next
              end

              i_origin = origins[i]
              j_origin = origins[j]
              k_origin = origins[k]

              key = build_key(i_stem, j_stem, k_stem)
              value = "#{i_origin} #{j_origin} #{k_origin}"

              if skip_ngrams.include? value.split(' ').sort().join(' ')
                skip_ngram_stems.add key
                stem_frequencies.delete key
                stem_origins.delete key
              elsif not skip_ngram_stems.include? key
                stem_frequencies[key] += 1
                stem_origins[key][value] += 1

                if sample_sentences[key].length < n_samples
                  sample_sentences[key] << proc_answer.original_text
                end
              end
            end
          end
        end
      end
    end

    build_wordcloud_result(stem_frequencies, stem_origins, sample_sentences, 100)
  end

  def ngrams(survey, n, filter, category, remove_ngrams)
    skip_ngrams = hash_ngrams remove_ngrams
    skip_ngram_stems = Set.new
    n_samples = 3

    filtered_answers = filter_answers(answers, filter, category)
    proc_answers = ProcessedAnswer.where(answer_id: filtered_answers.pluck(:id)).includes(:answer)

    stem_frequencies = Hash.new(0)
    stem_origins = Hash.new {|hash,key| hash[key] = Hash.new(0)}
    sample_sentences = Hash.new {|hash,key| hash[key] = Array.new}

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

          if ngram_stems.uniq.length != n
            next
          end

          ngram_origins = indices.map { |index| origins[index] }

          key = build_key(ngram_stems)
          value = ngram_origins.join(' ')

          if skip_ngrams.include? value.split(' ').sort().join(' ')
            skip_ngram_stems.add key
            stem_frequencies.delete key
            stem_origins.delete key
          elsif not skip_ngram_stems.include? key
            stem_frequencies[key] += 1
            stem_origins[key][value] += 1

            if sample_sentences[key].length < n_samples
              sample_sentences[key] << proc_answer.original_text
            end
          end

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

    build_wordcloud_result(stem_frequencies, stem_origins, sample_sentences, 100)
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

    def build_wordcloud_result(stem_frequencies, stem_origins, sample_sentences, n)
      wordcloud_stems = HashHelper.get_n_largest(stem_frequencies, n)

      word_cloud_ready_words = []
      wordcloud_stems.each do |stem|
        word_cloud_ready_words << {
          text: stem_origins[stem].max_by{|k,v| v}[0],
          size: stem_frequencies[stem],
          samples: sample_sentences[stem]
        }
      end

      result = {
        wordcloud: word_cloud_ready_words,
        stem_frequencies: stem_frequencies}
    end

    def hash_ngrams(remove_ngrams)
      ngrams = remove_ngrams.downcase.split(',')
      Set.new ngrams.map { |ngram| ngram.split(' ').sort().join(' ') }
    end
end
