class CloseEndedLoader
  @queue = :close_ended_queue
  def self.perform(survey_id, filepath)
    require 'fileutils'

    book = Spreadsheet.open(filepath)
    sheet = book.worksheet(0)
    header = sheet.row(0)

    time = "'#{Time.zone.now}'"

    survey = Survey.find(survey_id)
    model = SurveyModel.find(survey.survey_model_id)

    students = Student.where(id: Answer.where(survey_id: survey_id).pluck(:student_id).uniq)
    questions = CloseEndedQuestion.where(survey_model_id: model.id)
    options = Hash.new

    parser = {
      '1' => "Insatisfecho",
      '2' => "Insatisfecho",
      '3' => "Insatisfecho",
      '4' => "Insatisfecho",
      '5' => "Neutro",
      '6' => "Satisfecho",
      '7' => "Satisfecho"
    }

    questions.each do |q|
      options[q.id] = Hash[ q.options.collect { |x| [x.name, x.id] } ]
    end

    student_id_map = Hash[ students.collect { |x| [x.identifier, x.id] } ]
    question_id_map = Hash[ questions.collect { |x| [x.name, x.id] } ]

    inserts = []
    sheet.each 1 do |row|
      student_id = student_id_map[row[0].to_s]

      questions.each do |q|
        content = row[q.index]
        if content.length > 0
          option_text = parser[content]
          option = options[q.id][option_text]
          values = [
            q.id,
            student_id,
            survey_id,
            option.id,
            time,
            time
          ]
          inserts.push("(#{values.join(", ")})")
        end
      end
    end

    sql = "INSERT INTO close_ended_answers (close_ended_question_id, student_id, survey_id, text, created_at, updated_at) VALUES #{inserts.join(", ")};"
    ActiveRecord::Base.connection.exec_query(sql, :skip_logging)
    FileUtils.rm filepath
  end
end