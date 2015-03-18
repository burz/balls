class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.date :end_date
      t.integer :players_per_team
      t.integer :cups_per_team
      t.text :additional_rules
      t.belongs_to :league

      t.timestamps null: false
    end
  end
end
