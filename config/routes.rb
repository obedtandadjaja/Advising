Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"
  
  get '/' => 'sessions#new'

  # these routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  # post method of the login
  post '/login' => 'sessions#create'
  # get the user out
  get '/logout' => 'sessions#destroy'

  # get the view for the sign up
  get '/signup' => 'users#new'

  # get the view of advising
  get '/advising' => 'advising#index'

  get '/home' => 'home#index'

  put '/advising_ajax/:id' => 'advising#advising_ajax'

  put '/advising_ajax_delete/:id' => 'advising#advising_ajax_delete'

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
  resources :password_resets
  
end
