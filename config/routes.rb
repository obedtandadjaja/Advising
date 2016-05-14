Rails.application.routes.draw do
  default_url_options :host => "localhost:3000"

  root to: 'advising#index'

  # get the view for the sign up
  get '/signup' => 'users#new'

  # get the view of advising
  get '/advising' => 'advising#index'

  put '/advising_ajax/:id' => 'advising#advising_ajax'

  put '/advising_ajax_move/:id' => 'advising#advising_ajax_move'

  put '/advising_ajax_delete/:id' => 'advising#advising_ajax_delete'

  put '/add_plan' => 'advising#add_plan'

  put '/edit_plan/:id' => 'advising#edit_plan'

  get '/change_plan/:id' => 'advising#change_plan'

  put '/delete_plan/:id' => 'advising#delete_plan'

  devise_for :users, controllers: {
    # sessions: "users/sessions",
    registrations: "users/registrations"
  }

  # Guest
  post '/create_guest' => 'users#create_guest'

  post '/become_student' => 'users#become'

  resources :courses
  resources :majors
  resources :minors
  resources :distributions
  resources :concentrations
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
