Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  scope path: 'api' do
    resources :students do
      get 'next_activity' => 'students#next_activity'
    end
  end
end
