class ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /manufacturers
  # GET /manufacturers.json
  def index
    # Retrieve only the Manufacturers that are associated with the current user by finding the Trade Events the user interacted with the Manufacturer
    # See "events_attended" scope on Manufacturer model
    @manufacturers = Manufacturer.order_by_company_name.events_attended(current_user.trade_events.pluck(:id))
    # @manufacturers = Manufacturer.includes(:trade_events).where(trade_events: {id: current_user.trade_events.pluck(:id)})
  end

  def search
    @manufacturers = Manufacturer.order_by_company_name.events_attended(current_user.trade_events.pluck(:id))
    if params[:company_name]
      @manufacturers = @manufacturers.by_company_name(params[:company_name].downcase.split(" ").map! {|x| x.capitalize}.join(" "))
    end
    if params[:contact_name]
      @manufacturers = @manufacturers.by_contact_name(params[:contact_name].downcase.split(" ").map! {|x| x.capitalize}.join(" "))
    end
    if params[:shipping_port]
      @manufacturers = @manufacturers.by_shipping_port(params[:shipping_port].downcase.split(" ").map! {|x| x.capitalize}.join(" "))
    end
    render :action => :index
  end

  # GET /manufacturers/1
  # GET /manufacturers/1.json
  def show
  end

  # GET /manufacturers/new
  def new
    @manufacturer = Manufacturer.new
  end

  # GET /manufacturers/1/edit
  def edit
  end

  # POST /manufacturers
  # POST /manufacturers.json
  def create
    # Creates a new Manufacturer record using the data entered the form fields
    @manufacturer = Manufacturer.new(manufacturer_params)
    # Creates a new Attending Manufacturer join record matching the new Manufacturer record with the selected Trade Event
    @manufacturer.attending_manufacturers.build(manufacturer_id: @manufacturer.id, trade_event_id: params["manufacturer"]["attending_manufacturer"]["trade_event_id"].to_i)
    
    respond_to do |format|
      if @manufacturer.save
        format.html { redirect_to @manufacturer, notice: 'Manufacturer was successfully created.' }
        format.json { render :show, status: :created, location: @manufacturer }
      else
        format.html { render :new }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manufacturers/1
  # PATCH/PUT /manufacturers/1.json
  def update
    respond_to do |format|
      if @manufacturer.update(manufacturer_params)
        format.html { redirect_to @manufacturer, notice: 'Manufacturer was successfully updated.' }
        format.json { render :show, status: :ok, location: @manufacturer }
      else
        format.html { render :edit }
        format.json { render json: @manufacturer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manufacturers/1
  # DELETE /manufacturers/1.json
  def destroy
    @manufacturer.destroy
    respond_to do |format|
      format.html { redirect_to manufacturers_url, notice: 'Manufacturer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manufacturer
      @manufacturer = Manufacturer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manufacturer_params
      # params.require(:manufacturer).permit(:company_name, :shipping_port, :contact_name, :email, :phone_number, :attending_manufacturer => [:trade_event_id], :address_attributes => [:street_address_1, :street_address_2, :street_address_3, :city, :district, :state, :postal_code, :country])
      params.require(:manufacturer).permit(:company_name, :shipping_port, :contact_name, :email, :phone_number, :address_attributes => [:street_address_1, :street_address_2, :street_address_3, :city, :district, :state, :postal_code, :country])
    end

    def authorize
      if current_user.nil?
        redirect_to login_url, alert: "Not authorized! Please log in."
      else
        if @manufacturer && @manufacturer.trade_events.first.buyer != current_user
          redirect_to root_path, alert: "You are not authorized to access this trade event."
        end
      end
    end
end
