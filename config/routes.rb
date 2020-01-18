Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "videos#intro", as: :user_root
  constraints subdomain: /^#{Settings.domain.user}/ do
    defaults subdomain: "user" do
      scope module: :user, as: :user do
        get "sign_in", to: "sessions#new"
        post "sign_in", to: "sessions#create"
        resources :videos
      end
    end
  end
end
