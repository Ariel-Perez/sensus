class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :close_ended_questions_options, id:false do |t|
      t.belongs_to :close_ended_question, index: true
      t.belongs_to :option, index: true
    end
  end
end
