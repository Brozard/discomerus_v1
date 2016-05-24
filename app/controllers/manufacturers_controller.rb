class ManufacturersController < ApplicationController
  before_action :set_manufacturer, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /manufacturers
  # GET /manufacturers.json
  def index
    @manufacturers = Manufacturer.includes(:trade_events).where(trade_events: {id: current_user.trade_events.pluck(:id)})
  end

  # GET /manufacturers/1
  # GET /manufacturers/1.json
  def show
  end

  # GET /manufacturers/new
  def new
    @manufacturer = Manufacturer.new
    # Experimental for Trade Event selection
    # @manufacturer.trade_events.build
    # End of experimental code
  end

  # GET /manufacturers/1/edit
  def edit
  end

  # POST /manufacturers
  # POST /manufacturers.json
  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    # p @manufacturer.attending_manufacturers
    # Experimental for Trade Event selection
    # @manufacturer = current_user.trade_events.build(manufacturer_params)
    # @attending_manufacturer = AttendingManufacturer.new(manufacturer_params[:trade_event_id], manufacturer_params[:manufacturer_id])
    # @attending_manufacturer = AttendingManufacturer.new(@manufacturer.attending_manufacturer, @manufacturer.id)
    # @attending_manufacturer = AttendingManufacturer.new(@manufacturer.attending_manufacturer.attending_manufacturers, @manufacturer.id)
    @manufacturer.attending_manufacturers.build(manufacturer_id: @manufacturer.id, trade_event_id: params["manufacturer"]["attending_manufacturer"]["trade_event_id"].to_i)
    # @manufacturer.attending_manufacturers.build(manufacturer_id: @manufacturer.id, trade_event_id: @manufacturer.attending_manufacturers[0])
    # @manufacturer.attending_manufacturers << @manufacturer
    # @manufacturer.attending_manufacturers.update(manufacturer_id: @manufacturer.id, trade_event_id: @manufacturer)
    # End of experimental code

    respond_to do |format|
      if @manufacturer.save
        # @attending_manufacturer.save
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
