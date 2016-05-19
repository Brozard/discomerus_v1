class TradeEventsController < ApplicationController
  before_action :set_trade_event, only: [:show, :edit, :update, :destroy]

  # GET /trade_events
  # GET /trade_events.json
  def index
    @trade_events = TradeEvent.all
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
    @trade_event = TradeEvent.new(trade_event_params)

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
      params.require(:trade_event).permit(:possible_trade_event, :is_correct, :question_id)
    end
end
