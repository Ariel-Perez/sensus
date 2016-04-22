class SentimentLoader
  @queue = :sentiments_queue
  def self.perform(filepath)
    require 'fileutils'

    book = Spreadsheet.open(filepath)
    sheet = book.worksheet(0)
    header = sheet.row(0)
    header_length = header.length

    time = "'#{Time.zone.now}'"

    sentiments = Sentiment.all

    sentiment_hash = {}
    sentiments.each do |sentiment|
      sentiment_hash[sentiment.name] = sentiment.id
    end

    inserts = []
    sheet.each 1 do |row|
      answer_id = row[0].to_s
      student_id = row[1].to_s
      original_text = row[2].to_s
      sentiment = row[3].to_s.encode 'UTF-8'
      sentiment_id = sentiment_hash[sentiment]

      inserts.push("(#{answer_id},#{sentiment_id},#{time},#{time})")
    end

    sql = "INSERT INTO answer_sentiments (answer_id, sentiment_id, created_at, updated_at) VALUES #{inserts.join(", ")};"
    ActiveRecord::Base.connection.exec_query(sql, :skip_logging)
    FileUtils.rm filepath
  end
end