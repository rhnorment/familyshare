Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root      'static#home'

  get       'how_it_works'  =>    'static#how'
  get       'showcase'      =>    'static#showcase'
  get       'signup'        =>    'users#new'
  get       'signin'        =>    'sessions#new'
  get       'search',       to:   'search#search'

  get       '/404'          =>    'errors#not_found'
  get       '/422'          =>    'errors#unprocessable'
  get       '/500'          =>    'errors#server_error'

  resource  :session
  resources :users,             except: :index
  resources :relationships do
    get 'pending', on: :collection
  end
  resources :invitations,       except: :index
  resources :storybooks
  resources :stories
  resources :search,            only:   :index
  resources :activities,        only:   :index
  resources :password_resets,   only:   [:new, :create, :edit, :update]

end
