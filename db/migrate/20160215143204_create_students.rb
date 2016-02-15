class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :identifier
      t.string :meta

      t.timestamps null: false
    end
  end
end
