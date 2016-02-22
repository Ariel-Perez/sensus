class Survey < ActiveRecord::Base
  validates :name,  presence: true
  # validates :path,  presence: true
  validates :user_id,  presence: true
  validates :survey_model_id,  presence: true

  belongs_to :user
  belongs_to :survey_model
  has_many :answers

  def self.import(params, file)
    spreadsheet = self.open_spreadsheet(file)
    header = spreadsheet.row(1)

    survey = Survey.new(params)
    Survey.transaction do
      survey.path = spreadsheet.last_row.to_s
      survey.save

      questions = Question.where(survey_model_id: survey.survey_model_id)
      model = SurveyModel.find(survey.survey_model_id)

      (2..spreadsheet.last_row).each do |i|
        row = spreadsheet.row(i)
        student_identifier = row[model.student_identifier]
        student = Student.find_or_create_by(identifier: student_identifier)

        questions.each do |question|
          text = row[question.index] || ""
          Answer.create_with(text: text).find_or_create_by(
            question_id: question.id,
            student_id: student.id,
            survey_id: survey.id)
        end
      end
    end
    return survey
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, {})
    when ".xls" then Roo::Excel.new(file.path, {})
    when ".xlsx" then Roo::Excelx.new(file.path, {})
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
