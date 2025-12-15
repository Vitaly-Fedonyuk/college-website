Rails.application.routes.draw do
  get 'documents/index'
  get 'documents/new'
  get 'documents/create'
  # Root route
  root 'home#index'
  
  # News section
  resources :news, only: [:index, :show]
  
  # Documents section
  resources :documents
  
  # Static pages
  get 'students', to: 'students#index'
  get 'students/clubs', to: 'students#clubs', as: 'student_clubs'
  get 'applicants', to: 'applicants#index'
  get 'applicants/admission', to: 'applicants#admission', as: 'admission'
  get 'applicants/specialties', to: 'applicants#specialties', as: 'specialties'
  get 'public_info', to: 'pages#public_info'
  get 'departments', to: 'pages#departments'
  get 'quality_monitoring', to: 'pages#quality_monitoring'
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
