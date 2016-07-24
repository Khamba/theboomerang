class CartController < ApplicationController

  def show_without_layout
    @cart = get_shopping_cart
    render layout: false
  end

  def show
    @cart = get_shopping_cart
  end

  def add_item
    product = Product.find(params[:product_id])
    @cart_item = get_shopping_cart.add_item(product, cart_params)
    if @cart_item.valid?
      render 'item_added', layout: false
    else
      render 'item_not_added', layout: false
    end
  end

  def remove_item
    product = Product.find(params[:product_id])
    get_shopping_cart.remove_item(product)
    render layout: false
  end

  def empty_cart
    get_shopping_cart.empty_cart
    render status: 200
  end

  private

    def cart_params
      params.require(:cart).permit(:product_id, :delivery_date, :delivery_time, :size)
    end

end
