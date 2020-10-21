
Rails.application.routes.draw do
  # get 'welcome/index'
  # default_url_options :host => "example.com"
  # Rails.application.routes.default_url_options[:host] = true
  devise_for :users
  root 'welcome#index'
  resources :verifications, only: [:edit, :update]
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
