class ResultLoader
  @queue = :results_queue
  def self.perform(question_id, filepath)
    require 'fileutils'

    book = Spreadsheet.open(filepath)
    sheet = book.worksheet(0)
    header = sheet.row(0)
    header_length = header.length

    time = "'#{Time.zone.now}'"

    question = Question.find(question_id)
    categories = question.categories

    category_hash = {}
    categories.each do |category|
      category_hash[category.name] = category.id
    end

    inserts = []
    sheet.each 1 do |row|
      answer_id = row[0].to_s
      student_id = row[1].to_s
      original_text = row[2].to_s
      (3..row.length - 1).each do |i|
        if row[i].to_s.length > 0
          category_id = row[i].to_s.encode 'UTF-8'
          if category_hash.key?(category_id)
            category_id = category_hash[category_id]
          end
          inserts.push("(#{answer_id},#{category_id},#{time},#{time})")
        end
      end
    end

    sql = "INSERT INTO answer_categories (answer_id, category_id, created_at, updated_at) VALUES #{inserts.join(", ")};"
    ActiveRecord::Base.connection.exec_query(sql, :skip_logging)
    FileUtils.rm filepath
  end
end