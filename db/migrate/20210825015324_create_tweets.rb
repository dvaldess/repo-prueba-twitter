class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :content
      t.integer :total_tweet, :null => false, :default => 0
      t.integer :total_retweet, :null => false, :default => 0

      t.timestamps
    end
  end
end
