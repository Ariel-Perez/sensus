class StemLoader
  @queue = :stems_queue
  def self.perform(filepath)
    require 'fileutils'

    book = Spreadsheet.open(filepath)
    sheet = book.worksheet(0)
    header = sheet.row(0)

    time = "'#{Time.zone.now}'"

    inserts = []
    sheet.each 1 do |row|
      answer_id = row[0].to_s
      student_id = row[1].to_s
      original_text = row[2].to_s

      stemmed_text = row[3].to_s
      unstemmed_text = row[4].to_s

      inserts.push("(#{answer_id},'#{original_text}','#{unstemmed_text}','#{stemmed_text}',#{time},#{time})")
    end

    # inserts.each_slice(1000) do |slice|
    sql = "INSERT INTO processed_answers (answer_id, original_text, unstemmed_text, stemmed_text, created_at, updated_at) VALUES #{inserts.join(", ")};"
    ActiveRecord::Base.connection.exec_query(sql, :skip_logging)
    # end
    FileUtils.rm filepath
  end
end