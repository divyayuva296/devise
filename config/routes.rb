
Rails.application.routes.draw do
  # get 'welcome/index'
  devise_for :users
  root 'welcome#index'
  resources :verifications, only: [:edit, :update]
 
  resources :phone_verifications , only: [:new,:create]
  
  resources :posts do
    member do
      delete :delete_avatar
      delete :delete_photo
    end
  end
  # root 'main#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
