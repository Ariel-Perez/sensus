class AddDisplayToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :display, :boolean, :default => true
  end
end
