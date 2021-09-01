class RenameTweetTotalRetweetToRetweet < ActiveRecord::Migration[5.2]
  def change
    rename_column :tweets, :total_retweet, :retweet
   end
end
