class StemLoader
  @queue = :surveys_queue
  def self.perform(filepath)
    require 'fileutils'

    book = Spreadsheet.open(filepath)
    sheet = book.worksheet(0)
    header = sheet.row(0)

    time = '#{Time.zone.now}'

    inserts = []
    sheet.each 1 do |row|
      answer_id = row[0].to_s
      text = row[1].to_s
      stems = row[2].to_s

      inserts.push("(#{answer_id},#{text},#{stems}),#{time},#{time}")
    end

    sql = "INSERT INTO processed_answers (answer_id, unstemmed_text, stemmed_text, created_at, updated_at) VALUES #{inserts.join(", ")};"
    ActiveRecord::Base.connection.exec_query(sql, :skip_logging)
    FileUtils.rm filepath
  end
end