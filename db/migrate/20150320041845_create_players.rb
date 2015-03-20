class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :game
      t.belongs_to :user
      t.integer :team

      t.timestamps null: false
    end
  end
end
