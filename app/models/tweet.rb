class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy #Sobre si misma, para los retweet (recursivo)
  paginates_per 50 #Limitando para kamirami
  validates :content, presence: true #Validar la presencia del contenido

  #Metodo para buscar la imagenen del que Retwitea
  #Y asi poder ocuparlo en el index
  def master_avatar
    Tweet.find(self.tweet_id).user.avatar
  end
  #Metodo para buscar el nombre de la persona que Retwitea
  #Y asi poder ocuparlo en el index
  def master_username
    Tweet.find(self.tweet_id).user.username
  end
  #Contador de Retweet
  def self.count_retweets(tweet)
    Tweet.all.count {|t| t.tweet_id == tweet.id}
  end
end