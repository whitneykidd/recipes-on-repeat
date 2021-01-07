Rails.application.routes.draw do
  namespace :v1 do
    post 'users/register', to: 'users#register'
    post 'users/login', to: 'users#login'
  end
end
