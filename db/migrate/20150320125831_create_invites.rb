class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :token
      t.belongs_to :league

      t.timestamps null: false
    end
  end
end
