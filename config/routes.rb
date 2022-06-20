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

    resources :user_details 
    resources :skills
    resources :jobs
    resources :save_jobs do 
      collection do 
        post :add_or_remove_save_job
      end
    end
   resources :job_manager
    resources :educations do 
      collection do 
        get "/get_user_education/:id" => "educations#get_user_education"
      end
    end
    resources :experiences do 
      collection do 
        get "/get_user_experience/:id" => "experiences#get_user_experience"
      end
    end
    resources :user_cvs do
    end
    resources :user_cv do 
      collection do 
        patch "add_cv"
        get "show_all_cv"
      end
    end
   
  scope :company do
    resource :company_details
  end
end
