class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :user_timeout

  private

  # When retrieving params from non-text entry fields (I've primarily encountered this with numbers), Rails is returning an array containing a number as a string.
  # While I need the number, sometimes I need it as an integer, while other times I need it as a decimal. I'm not dealing with the conversion here.
  # Instead, I'm only testing whether or not the string inside the array is empty. If it is, nil is returned; if it isn't, I'm returning the first array element.
  # For this project, these arrays only have one element. If I encounter params that return multi-element arrays, this helper will not work.
  def extract_from_search(param)
    if param != nil
      param.first != "" ? param.first : nil
    else
      return
    end
  end

  def current_user
    Buyer.where(id: session[:buyer_id]).first
  end

  def user_timeout
    if current_user == nil
      redirect_to login_path # unless request.fullpath == '/login'
    else
      if session[:expires_at] < Time.current
        redirect_to timeout_path
      else
        session[:expires_at] = Time.current + 15.minutes
      end
    end
  end

  helper_method :extract_from_search
  helper_method :current_user
end
