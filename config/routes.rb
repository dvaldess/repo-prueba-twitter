Rails.application.routes.draw do
  namespace :api, defaults: {format: "json"} do
    namespace :v1 do
      get 'tweet/news'
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
  delete 'like/:id', to: 'likes#delete', as:'like_delete'
  root 'tweets#index'
end
