class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :name
      t.references :survey_model, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
