class SessionsController < ApplicationController
  skip_before_filter :user_timeout

  def new
  end

  def create
    # Create a new session by finding the Buyer record that matches the email entered
    buyer = Buyer.find_by_email(params[:email])
    # If the Buyer record exists and the password entered is correct...
    if buyer && buyer.authenticate(params[:password])
      # ...set the session user to that Buyer's ID, set an expiration timer to the session, and redirect to root.
      session[:buyer_id] = buyer.id
      session[:expires_at] = Time.current + 15.minutes
      redirect_to '/'
    # ...otherwise, re-render this page.
    else
      render :new
    end
  end

  def destroy
    # Use 'reset session' to completely destroy all session data
    reset_session
    redirect_to '/', notice: 'Logged out!'
  end

  def timeout
    reset_session
    # Use 'reset session' to completely destroy all session data
    redirect_to '/', notice: 'You have been logged out for being inactive too long.'
  end
end
