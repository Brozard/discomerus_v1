class SessionsController < ApplicationController
  def new
  end

  def create
    buyer = Buyer.find_by_email(params[:email])
    if buyer && buyer.authenticate(params[:password])
      session[:buyer_id] = buyer.id
      redirect_to '/'
    else
      render :new
    end
  end

  def destroy
    session[:buyer_id] = nil
    redirect_to '/', notice: 'Logged out!'
  end
end
