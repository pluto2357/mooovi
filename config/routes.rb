TechReviewSite::Application.routes.draw do
root 'products#index'

# get 'products/search'=>'products#search'
# get 'products/:id'=>'products#show'
# get 'products/:id/reviews/new'=>'products#'

 resources :users, only: :show
  resources :products, only: :show do
   resources :reviews, only: [:new, :create]
    collection do
      get 'search'
    end
  end


end