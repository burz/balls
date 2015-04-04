class CreateGods < ActiveRecord::Migration
  def change
    create_table :gods do |t|
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
