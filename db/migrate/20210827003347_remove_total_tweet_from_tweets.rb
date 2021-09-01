class RemoveTotalTweetFromTweets < ActiveRecord::Migration[5.2]
  def change
    remove_column :tweets, :total_tweet, :integer
  end
end
