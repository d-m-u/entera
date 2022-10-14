Rails.application.routes.draw do
  root to: 'colleges#index'
  get '/search' => 'colleges#search'
end
