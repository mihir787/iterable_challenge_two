Rails.application.routes.draw do

  # namespace :api do
  #   namespace :v1 do
  #     resources :transactions, only: [:create, :show]
  #   end
  # end

  scope format: true, defaults: { format: 'json' } do
    namespace :api do
      namespace :v1 do
        resources :transactions, only: [:create, :show]
      end
    end
  end

end
