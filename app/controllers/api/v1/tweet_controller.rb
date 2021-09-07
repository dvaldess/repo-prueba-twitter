class Api::V1::TweetController < ApplicationController::API

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: "diego", password: "123456"

  def news
    @tweets = Tweet.last(50)
    @api = []
    @tweet.each do |tweet|
      @api << { 
        id: tweet.id,
        content: tweet.content,
        user_id: tweet.user_id,
        like_count: tweet.likes.count,
        retweet_count: tweet.count_retweets,
      }
    end
    render json: @api
  end

  def by_date
    @first_date = params[:first_date]
    @last_date = params[:last_date]
    @tweets_by_date = Tweet.where('created_at BETWEEN ? AND ?', @first_date, @last_date)
    @api = []
    @tweets_by_date.each do |tweet|
      @api << {
        id: tweet.id,
        content: tweet.content,
        user_id: tweet.user_id,
        like_count: tweet.likes.count,
        retweet_count: tweet.count_retweets
      }
    end
    render json: @api
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

end
