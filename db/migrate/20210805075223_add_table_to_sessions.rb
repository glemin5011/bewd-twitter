class AddTableToSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.string :token
      t.integer :user_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
