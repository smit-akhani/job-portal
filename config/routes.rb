Rails.application.routes.draw do
  devise_for :companies,
              controllers: {
                sessions: 'companies/sessions',
                registrations: 'companies/registrations'
              }
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  get '/member-data', to: 'members#show'
  get '/company-data', to: 'companies#show'

    resources :user_details do 
      
    end
    resources :user_cv do 
      collection do 
        patch "add_cv"
        get "show_all_cv"
      end
    end
   
  scope :company do
    resources :company_details
  end

  scope :company do
    resources :company_details
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
