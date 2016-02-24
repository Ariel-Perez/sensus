class SurveyLoader
  @queue = :surveys_queue
  def self.perform(survey_params, filepath)
    require 'fileutils'

    survey = Survey.new(survey_params)
    survey.path = survey.name
    survey.save

    book = Spreadsheet.open(filepath)
    sheet = book.worksheet(0)
    header = sheet.row(0)

    model = SurveyModel.find(survey.survey_model_id)
    questions = Question.where(survey_model_id: model.id)

    student_ids = []
    answer_values = []
    sheet.each 1 do |row|
      student_identifier = row[model.student_identifier].to_s
      student_ids.push(student_identifier)

      questions.each do |question|
        text = ActiveRecord::Base.sanitize(row[question.index] || "")
        answer_values.push({
          question: question.id, 
          student: student_identifier,
          survey: survey.id,
          text: text
          })
      end
    end

    old_students = Student.where(identifier: student_ids)
    old_student_ids = old_students.pluck(:identifier)
    new_student_ids = student_ids - old_student_ids
    new_students = Student.create(new_student_ids.map {|x| {identifier: x}})
    all_students = old_students | new_students
    student_id_map = Hash[ all_students.collect { |x| [x.identifier, x.id] } ]

    inserts = []
    answer_values.each do |values|
      if values[:text].length > 2
        processed_values = [
          values[:question], 
          student_id_map[values[:student]], 
          values[:survey], 
          values[:text], 
          "'#{Time.zone.now}'", 
          "'#{Time.zone.now}'"
        ]
        inserts.push("(#{processed_values.join(", ")})")
      end
    end 

    sql = "INSERT INTO answers (question_id, student_id, survey_id, text, created_at, updated_at) VALUES #{inserts.join(", ")};"
    ActiveRecord::Base.connection.exec_query(sql, :skip_logging)
    FileUtils.rm filepath
  end
end