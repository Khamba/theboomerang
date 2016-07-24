# == Route Map
#
#                                Prefix Verb     URI Pattern                                  Controller#Action
#      user_facebook_omniauth_authorize GET|POST /users/auth/facebook(.:format)               auth/omniauth_callbacks#passthru
#       user_facebook_omniauth_callback GET|POST /users/auth/facebook/callback(.:format)      auth/omniauth_callbacks#facebook
# user_google_oauth2_omniauth_authorize GET|POST /users/auth/google_oauth2(.:format)          auth/omniauth_callbacks#passthru
#  user_google_oauth2_omniauth_callback GET|POST /users/auth/google_oauth2/callback(.:format) auth/omniauth_callbacks#google_oauth2
#                                logout DELETE   /logout(.:format)                            devise/sessions#destroy
#                            categories GET      /categories(.:format)                        categories#index
#                                       POST     /categories(.:format)                        categories#create
#                          new_category GET      /categories/new(.:format)                    categories#new
#                         edit_category GET      /categories/:id/edit(.:format)               categories#edit
#                              category PATCH    /categories/:id(.:format)                    categories#update
#                                       PUT      /categories/:id(.:format)                    categories#update
#                                       DELETE   /categories/:id(.:format)                    categories#destroy
#                                  root GET      /                                            welcome#home
#                   edit_images_product GET      /products/:id/edit_images(.:format)          products#edit_images
#                    add_images_product POST     /products/:id/add_images(.:format)           products#add_images
#                destroy_images_product POST     /products/:id/destroy_images(.:format)       products#destroy_images
#                              products POST     /products(.:format)                          products#create
#                           new_product GET      /products/new(.:format)                      products#new
#                          edit_product GET      /products/:id/edit(.:format)                 products#edit
#                               product GET      /products/:id(.:format)                      products#show
#                                       PATCH    /products/:id(.:format)                      products#update
#                                       PUT      /products/:id(.:format)                      products#update
#                                       DELETE   /products/:id(.:format)                      products#destroy
#                               western GET      /western(.:format)                           products#western_index
#                                ethnic GET      /ethnic(.:format)                            products#ethnic_index
#                       admin_dashboard GET      /admin_dashboard(.:format)                   welcome#admin_dashboard
#              cart_show_without_layout POST     /cart/show_without_layout(.:format)          cart#show_without_layout
#                             cart_show GET      /cart/show(.:format)                         cart#show
#                         cart_add_item POST     /cart/add_item(.:format)                     cart#add_item
#                      cart_remove_item POST     /cart/remove_item(.:format)                  cart#remove_item
#                       cart_empty_cart POST     /cart/empty_cart(.:format)                   cart#empty_cart
#

Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :omniauth_callbacks => "auth/omniauth_callbacks" }, :skip => [:sessions, :passwords, :registrations]
  devise_scope :user do
    delete "/logout" => "devise/sessions#destroy"
  end
  resources :categories, except: :show
  root 'welcome#home'
  resources :products, except: :index do
    member do
      get 'edit_images'
      post 'add_images'
      post 'destroy_images'
    end
  end
  get 'western', to: 'products#western_index'
  get 'ethnic', to: 'products#ethnic_index'
  get 'admin_dashboard', to: 'welcome#admin_dashboard'
  post 'cart/show_without_layout'
  get 'cart/show'
  post 'cart/add_item'
  post 'cart/remove_item'
  post 'cart/empty_cart'

end
