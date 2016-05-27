class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /products
  # GET /products.json
  def index
    @products = Product.user_products(current_user.id)
    # @products = Product.where(buyer_id: current_user.id)
  end

  def search
    
    @min_p = params[:min_price].first == "" ? 0 : params[:min_price].first# : nil
    @max_p = params[:max_price].first == "" ? 999999 : params[:max_price].first# : nil
      
    # @products = Product.user_products(current_user.id).by_price(params[:min_price], params[:max_price])
    @products = Product.user_products(current_user.id).by_price(@min_p, @max_p)
    if params[:name]
      @products = @products.by_name(params[:name])
    end
    # if params[:min_price] &&
    #   @products = @products.by_price(params[:price])
    # end
    # if params[:category]
    #   @products = @products.by_category(params[:category])
    # end
    render :action => :index
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:description, :item_number, :min_order_quantity, :name, :price, :buyer_id, :manufacturer_id)
    end

    def authorize
      if current_user.nil?
        redirect_to login_url, alert: "Not authorized! Please log in."
      else
        if @product && @product.buyer != current_user
          redirect_to root_path, alert: "You are not authorized to access this product."
        end
      end
    end
end
