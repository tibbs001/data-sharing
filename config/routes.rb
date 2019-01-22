Rails.application.routes.draw do

  get "/data_sharing"         => "data_sharing#show"
  get 'data_sharing/show'

  resources :sharable_datasets
end
