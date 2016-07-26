class ProductsController < ApplicationController

  before_action :authorize_only_admins, except: [ :western_index, :ethnic_index, :show ]

  def western_index
    @categories = Category.joins(:products).where('products.supercategory' => 'Western').distinct
    @products = Product.where('supercategory' => 'Western').distinct
    if params[:filters]
      if filter_params[:range_min] && filter_params[:range_max]
        @products = @products.where('rent_price >= ?', filter_params[:range_min]).where('rent_price <= ?', filter_params[:range_max])
      end
      if filter_params[:categories]
        @products = @products.where('id IN (SELECT product_categories.product_id FROM product_categories WHERE category_id IN (?) GROUP BY product_id HAVING COUNT(DISTINCT category_id) = ?)', filter_params[:categories], filter_params[:categories].length)
      end
      if filter_params[:sizes]
        @products = @products.where("sizes @> ARRAY[?]::varchar[]", filter_params[:sizes])
      end
      if params[:sort] == "low"
        @products = @products.order(:rent_price)
      end
      if params[:sort] == "high"
        @products = @products.order(rent_price: :desc)
      end
    end
    render 'index'
    # Product.where("sizes @> ARRAY[?]::varchar[]", ['S', 'M'])
  end

  def ethnic_index
    @categories = Category.joins(:products).where('products.supercategory' => 'Ethnic').distinct
    @products = Product.where('supercategory' => 'Ethnic')
    render 'index'
  end

  def edit
    @product = Product.find(params[:id])
  end

  def edit_images
    @product = Product.find(params[:id])
  end

  def destroy_images
    @product = Product.find(params[:id])
    if params[:product_images_ids].length >= @product.product_images.count
      redirect_to edit_images_product_url, notice: 'You cannot delete all the images.'
    else
      if @product.product_images.where(id: params[:product_images_ids]).destroy_all
        redirect_to edit_images_product_url, notice: 'Images were successfully deleted.'
      else
        redirect_to edit_images_product_url, notice: 'Images were NOT successfully deleted.'
      end
    end
  end

  def add_images
    @product = Product.find(params[:id])
    begin
      params['product_images'].reject(&:blank?).each do |image|
        @product.product_images.create!(image: image)
      end
      redirect_to edit_images_product_url, notice: 'Images were successfully added.'
    rescue
      redirect_to edit_images_product_url, notice: 'There was an error while adding images.'
    end
  end

  def show
    @product = Product.find(params[:id])
    @product_images = @product.product_images.all
    @cart_item = get_shopping_cart.shopping_cart_items.where(product: @product).first_or_initialize
  end

  def new
    @product = Product.new
    @product.product_images.build
  end

  def create
    @product = Product.new(product_params)
    begin
      params['product_images']['image'].compact.each do |image|
        @product.product_images.build(image: image)
      end
    rescue NoMethodError
    end
    begin
      params['product_categories']['category_id'].each do |cid|
        category = Category.find(cid)
        @product.product_categories.build(category: category)
      end
    rescue NoMethodError
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
      else
        @product.product_images.destroy_all
        @product.product_images.build
        format.html { render action: 'new' }
      end
    end
  end

  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(product_params)
        @product.product_categories.destroy_all
        begin
          params['product_categories']['category_id'].each do |cid|
            category = Category.find(cid)
            @product.product_categories.create(category: category)
          end
        rescue NoMethodError
        end
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
      else
        format.html { render action: 'edit', notice: 'Product could not be updated.' }
      end
    end
  end

  private
     def product_params
        params.require(:product).permit(:name, :rent_price, :actual_price, :description, :supercategory, product_images_attributes: [ :image ], sizes: [], product_categories_attributes: [ :category_id ])
     end

     def filter_params
       params.require(:filters).permit(:range_min, :range_max, :sort, categories: [], sizes: [])
     end

     def authorize_only_admins
      authorize(Product, :is_admin?)
    end

end
