class SessionsController < ApplicationController
  skip_before_filter :user_timeout

  def new
  end

  def create
    buyer = Buyer.find_by_email(params[:email])
    if buyer && buyer.authenticate(params[:password])
      session[:buyer_id] = buyer.id
      session[:expires_at] = Time.current + 15.minutes
      redirect_to '/'
    else
      render :new
    end
  end

  def destroy
    # session[:buyer_id] = nil
    reset_session
    redirect_to '/', notice: 'Logged out!'
  end

  def timeout
    reset_session
    redirect_to '/', notice: 'You have been logged out for being inactive too long.'
  end
end
