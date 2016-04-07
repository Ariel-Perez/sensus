class FilterLoader
  @queue = :filter_queue
  def self.perform(survey_id, filepath)
    require 'fileutils'

    book = Spreadsheet.open(filepath)
    sheet = book.worksheet(0)
    header = sheet.row(0)

    time = "'#{Time.zone.now}'"

    survey = Survey.find(survey_id)
    model = SurveyModel.find(survey.survey_model_id)
    filters = Filter.where(survey_model_id: model.id)
    filter_name_id_map = Hash[ filters.collect { |f| [f.name, f.id] } ]

    # FIRST COLLECT ALL THE MODELS

    student_identifiers = []
    # Hash with arrays to collect all found values for all filters
    filter_values = Hash[ filters.collect { |f| [f.id, Set.new] } ]

    sheet.each 1 do |row|
      student_identifiers.push(row[0].to_s)
      (1..row.length - 1).each do |i|
        filter_id = filter_name_id_map[header[i]]
        filter_values[filter_id].add(row[i].to_s)
      end
    end

    # MAP MODELS TO THEIR IDENTIFIERS
    student_identifier_id_map = Hash[ Student.where(identifier: student_identifiers).
                                      collect { |s| [s.identifier, s.id] } ]

    # ALSO CREATE MODELS IF NEEDED
    filter_value_objects = Hash[ filters.collect { |f| [f.id, {}] } ]
    filters.each do |filter|
      key = filter.id
      filter_values[key].each do |value|
        fv_obj = FilterValue.find_or_create_by(filter_id: key, value: value)
        filter_value_objects[key][value] = fv_obj
      end
    end

    # NOW ITERATE AGAIN CREATING THE JOINS
    inserts = []
    sheet.each 1 do |row|
      student_identifier = row[0].to_s
      student_id = student_identifier_id_map[student_identifier]

      (1..row.length - 1).each do |i|
        filter_id = filter_name_id_map[header[i]]
        filter_value = row[i].to_s

        fv_id = filter_value_objects[filter_id][filter_value].id

        inserts.push("(#{survey_id},#{student_id},#{fv_id},#{time},#{time})")
      end
    end

    sql = "INSERT INTO student_survey_filter_values (survey_id, student_id, filter_value_id, created_at, updated_at) VALUES #{inserts.join(", ")};"
    ActiveRecord::Base.connection.exec_query(sql, :skip_logging)
    FileUtils.rm filepath
  end
end