Rails.application.routes.draw do
  root "static_pages#home"

  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: :show

  namespace :admin do
    root "home#index"
    resources :users
    resources :teams
    resources :positions
    resources :skills
    resources :activities, only: [:index, :destroy]

    resources :management_users do
      member do
        get "move-team", to: "management_users#move_to_other_team"
        patch "move-team", to: "management_users#update_to_other_team"
        delete "delete-team", to: "management_users#delete_from_team"
      end
    end

    resources :management_teams do
      member do
        get "add-member", to: "management_teams#add_member"
        patch "add-member", to: "management_teams#update_member_team"
        patch "empty-member-team", to: "management_teams#empty_member_team"
      end
    end
  end
end
