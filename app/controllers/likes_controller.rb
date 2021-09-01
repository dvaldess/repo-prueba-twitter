class LikesController < ApplicationController
  before_action :authenticate_user!#Regla que provoca que solo los usuarios autentificados pueden utilizar los metodos
  
  def create #Metodo para crear los like
    tweet = Tweet.find(params[:tweet_id])#Busca el id del tweet
    new_like = Like.create!(tweet: tweet, user:current_user) #En la variable se almacena el like segun el usuario conectado
    redirect_to root_path#Luego de la acción anterior, que se te envia al home
  end

  def delete #Metodo para quitar los Like
    tweet = Tweet.find(params[:id])#Se busca el id del tweet
    like = tweet.likes.find_by(user: current_user)#Se guarda en una variable el registro que une el tweet con el like en base al usuario conectado
    like.destroy #Se remueve el like
    redirect_to root_path #Luego de la acción anterior, que se te envia al home
  end

end
