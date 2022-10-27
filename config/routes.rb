Rails.application.routes.draw do

  root "todos#home"
  resources :todos

  scope :auth do
    get "sign-in", to: "auth#sign_in", as: :sign_in
    post "sign-in", to: "auth#login", as: :login
    get "sign-up", to: "auth#sign_up", as: :sign_up
    post "sign-up", to: "auth#create_user", as: :create_user
    post "logout", to: "auth#logout", as: :logout
  end

end
