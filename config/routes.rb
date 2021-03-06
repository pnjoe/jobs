Rails.application.routes.draw do
  resources :topics
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :jobs do
    collection do
      get :search
    end
    resources :resumes
  end


  namespace :admin do
    resources :jobs do
      member do
        post :publish
        post :hide
      end
      resources :resumes
    end
  end

  resources :welcome
  root 'welcome#index'
  get "/pages/:action" , :controller => "pages"
end
