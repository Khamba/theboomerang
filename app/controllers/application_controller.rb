class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :create_guest_if_needed
  before_filter :get_shopping_cart
  helper_method :after_omniauth_failure_path_for, :user_or_guest
    

  protected

    def after_omniauth_failure_path_for(scope)
      root_path
    end

    def after_sign_in_path_for(resource_or_scope)
      if @cart.item_count == 0 && current_user.shopping_carts.last
        @cart = current_user.shopping_carts.last
      else
        @cart.update(owner: current_user)
      end
      root_path
    end

    def user_or_guest
      current_user || @guest
    end

    def create_guest_if_needed
      return if session[:guest_token] # already logged in, don't need to create another one
      @guest = Guest.create
      session[:guest_token] = @guest.token
    end

    def get_shopping_cart
      @cart ||= ShoppingCart.where(owner: user_or_guest).first_or_create
      return @cart
    end


end
