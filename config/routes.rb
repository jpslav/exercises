Exercises::Application.routes.draw do

  root 'static_pages#home'

  get 'status', to: lambda { |env| [204, {}, ['']] }

  scope module: 'static_pages' do
    get 'about'
    get 'contact'
    get 'copyright'
    get 'developers'
    get 'help'
    get 'privacy'
    get 'publishing'
    get 'share'
    get 'terms'
  end

  mount OpenStax::Accounts::Engine, at: "/accounts"
  mount FinePrint::Engine => "/fine_print"

  use_doorkeeper do
    controllers :applications => 'oauth/applications'
  end

  apipie

  api :v1, :default => true do
    resources :exercises do
      publishable
      has_logic

      resources :solutions do
        publishable
        has_logic
      end
    end

    resources :logics, only: [] do
      post 'seeds', on: :member
    end

    resources :libraries do
      publishable
    end

    resources :lists do
      publishable
    end

    resources :users, only: [:index]

    resource :user, only: [:show, :update, :destroy] do
      resources :deputizations, only: [:index, :create, :destroy], path: 'deputies'
    end
  end
  
  namespace 'admin' do
    get '/', to: 'console#index'

    resources :administrators, only: [:index, :create, :destroy]

    resource :cron, only: [:update]

    resources :exceptions, only: [:show]

    resources :formats

    resources :languages

    resources :licenses

    resources :required_libraries, only: [:index, :create, :destroy]

    resources :trusted_applications, only: [:index, :create, :destroy]

    resources :users, only: [:index] do
      member do
        put 'become'
        patch 'delete'
        patch 'undelete'
      end
    end
  end

  namespace :dev do
    resources :users, only: [:create] do
      post 'generate', on: :collection
    end
  end

  resources :exercises, only: [:show]

end
