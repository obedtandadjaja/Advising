Rails.application.routes.draw do

  get '/' => 'sessions#new'

  # these routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  # post method of the login
  post '/login' => 'sessions#create'
  # get the user out
  get '/logout' => 'sessions#destroy'

  # get the view for the sign up
  get '/signup' => 'users#new'
  # post method of the sign up
  post '/users' => 'users#create'

  # get the view of welcome
  get '/welcome' => 'welcome#index'

  get '/home' => 'home#index'

  resources :courses
  resources :majors
  resources :distributions
  resources :concentrations
  resources :users_courses
  resources :concentrations_courses
  
end
