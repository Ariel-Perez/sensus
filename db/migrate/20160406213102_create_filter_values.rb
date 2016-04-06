class CreateFilterValues < ActiveRecord::Migration
  def change
    create_table :filter_values do |t|
      t.string :value
      t.references :filter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
