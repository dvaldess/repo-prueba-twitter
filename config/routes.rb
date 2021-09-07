Rails.application.routes.draw do
  namespace :api, defaults: {format: "json"} do
    namespace :v1 do
      get 'news', to: 'tweets#news'
      get ':first_date/:last_date', to: 'tweets#by_date'
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :tweets do #Rutas anidadas entre el tweet y like, siempre los like van a pertenecer a los tweets
    resources :likes
  end
  resources :users do #Rutas anidadas entre los usuarios y los retweet. ya que el retweet es del usuario
    member do
      get 'quote', to: "tweets#quote", as:"quote" #Ruta para los retweet
    end
    resources :tweet
  end
  #Ruta para eliminar los like
  delete 'like/:id', to: 'likes#delete', as:'like_delete' 
  #Ruta para los seguidores
  post 'follows/:id', to: 'follows#to_follow', as: 'follow'
  delete 'follows/:id', to: 'follows#to_unfollow', as: 'unfollow'
  root 'tweets#index'
end
