class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.string :path

      t.timestamps null: false
    end
    add_reference :surveys, :user, index: true
    add_foreign_key :surveys, :users
  end
end
