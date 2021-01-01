Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "videos#intro", as: :user_root
  constraints subdomain: /^#{Settings.domain.user}/ do
    defaults subdomain: "user" do
      scope module: :user, as: :user do
        get "sign_in", to: "sessions#new"
        post "sign_in", to: "sessions#create"
        get "sign_up", to: "users#new"
        resources :users, only: [:new]
        resources :videos
        get :download_video, to: "base#download_video"
        get :get_m3u8, to: "base#get_m3u8"
      end
    end
  end
end
