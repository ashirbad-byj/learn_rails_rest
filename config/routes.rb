Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/api/v1/customers", to: "api/v1/customers#getCustomers"
  
  get "/api/v1/customers/:id", to: "api/v1/customers#getCustomerWithId"

  post "/api/v1/customers", to: "api/v1/customers#addCustomer"

  delete "/api/v1/customers", to: "api/v1/customers#deleteCustomer"

  patch "/api/v1/customers", to: "api/v1/customers#editCustomer"




  get "/api/v1/items", to: "api/v1/items#getItems"
  
  get "/api/v1/items/:id", to: "api/v1/items#getItemWithId"

  post "/api/v1/items", to: "api/v1/items#addItem"

  delete "/api/v1/items", to: "api/v1/items#deleteItem"

  patch "/api/v1/items", to: "api/v1/items#editItem"



  get "/api/v1/orders", to: "api/v1/orders#getOrders"
  
  post "/api/v1/orders", to: "api/v1/orders#addOrder"

  delete "/api/v1/orders", to: "api/v1/orders#deleteOrder"

  patch "/api/v1/orders", to: "api/v1/orders#editOrder"

end
