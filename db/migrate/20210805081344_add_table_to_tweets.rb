class AddTableToTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|

      t.string :message
      t.integer :user_id, index: true, foreign_key: true
      t.timestamps null: false

    end
  end
end
