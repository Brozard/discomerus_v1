class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /products
  # GET /products.json
  def index
    @products = Product.order_by_product_name.user_products(current_user.id)

    # @products_report  = ProductReport.new(product: @products)
  end

  def search
    # Define instance min/max price variables so that we can validate if anything was searched for
    # and send either the sanitized or default parameter to the "by_price" function
    @min_p = extract_from_search(params[:min_price]) || 0
    @max_p = extract_from_search(params[:max_price]) || 10000
    @cat = extract_from_search(params[:category])

    @products = Product.order_by_product_name.user_products(current_user.id).by_price(@min_p, @max_p)
    if params[:name]
      @products = @products.by_name(params[:name].downcase.split(" ").map! {|x| x.capitalize}.join(" "))
    end
    if !@cat.nil?
      @products = @products.by_category(@cat)
    end

    # @products_report  = ProductReport.new(product: @products)

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
    @product.price = (params[:product][:price].to_d * 100).to_i
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
