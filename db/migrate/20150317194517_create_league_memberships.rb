class CreateLeagueMemberships < ActiveRecord::Migration
  def change
    create_table :league_memberships do |t|
      t.belongs_to :user
      t.belongs_to :league
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
