json.extract! tweet, :id, :content, :total_tweet, :total_retweet, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
