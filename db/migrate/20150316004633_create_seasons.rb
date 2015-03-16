class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.int :players_per_team
      t.int :cups_per_team
      t.text :additional_rules

      t.timestamps null: false
    end
  end
end
