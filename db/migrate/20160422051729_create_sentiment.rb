class CreateSentiment < ActiveRecord::Migration
  def change
    create_table :sentiments do |t|
      t.string :name
    end
  end
end
