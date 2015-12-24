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

  # get the view of welcome
  get '/welcome' => 'welcome#index'

  get '/home' => 'home#index'

  put '/advising_ajax/:id' => 'welcome#advising_ajax'

  resources :courses
  resources :majors
  resources :minors
  resources :distributions
  resources :concentrations
  resources :users_courses
  resources :concentrations_courses
  resources :distributions_courses
  resources :majors_courses
  resources :users_majors
  resources :users_minors
  resources :users_concentrations
  resources :minors_courses
  resources :users
  resources :course_prerequisites
  
end
