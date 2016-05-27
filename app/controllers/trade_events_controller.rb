class TradeEventsController < ApplicationController
  before_action :set_trade_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize

  # GET /trade_events
  # GET /trade_events.json
  def index
    # Retrieve the Trade Events that are associated with the current user
    @trade_events = TradeEvent.user_events(current_user.id)
  end

  def search
    @trade_events = TradeEvent.user_events(current_user.id)
    if params[:event_name]
      @trade_events = @trade_events.by_event_name(params[:event_name].downcase.split(" ").map! {|x| x.capitalize}.join(" "))
    end
    if params[:city]
      @trade_events = @trade_events.by_city(params[:city].downcase.split(" ").map! {|x| x.capitalize}.join(" "))
    end
    render :action => :index
  end

  # GET /trade_events/1
  # GET /trade_events/1.json
  def show
  end

  # GET /trade_events/new
  def new
    @trade_event = TradeEvent.new
  end

  # GET /trade_events/1/edit
  def edit
  end

  # POST /trade_events
  # POST /trade_events.json
  def create
    @trade_event = current_user.trade_events.build(trade_event_params)

    respond_to do |format|
      if @trade_event.save
        format.html { redirect_to @trade_event, notice: 'Trade event was successfully created.' }
        format.json { render :show, status: :created, location: @trade_event }
      else
        format.html { render :new }
        format.json { render json: @trade_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trade_events/1
  # PATCH/PUT /trade_events/1.json
  def update
    respond_to do |format|
      if @trade_event.update(trade_event_params)
        format.html { redirect_to @trade_event, notice: 'Trade event was successfully updated.' }
        format.json { render :show, status: :ok, location: @trade_event }
      else
        format.html { render :edit }
        format.json { render json: @trade_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_events/1
  # DELETE /trade_events/1.json
  def destroy
    @trade_event.destroy
    respond_to do |format|
      format.html { redirect_to trade_events_url, notice: 'Trade event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade_event
      @trade_event = TradeEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trade_event_params
      params.require(:trade_event).permit(:event_name, :start_date, :end_date, :address_attributes => [:street_address_1, :street_address_2, :street_address_3, :city, :district, :state, :postal_code, :country])
    end

    def authorize
      if current_user.nil?
        redirect_to login_url, alert: "Not authorized! Please log in."
      else
        if @trade_event && @trade_event.buyer != current_user
          redirect_to root_path, alert: "You are not authorized to access this trade event."
        end
      end
    end
end
