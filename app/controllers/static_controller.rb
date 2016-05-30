class StaticController < ApplicationController
  def welcome
    if current_user.nil?
      redirect_to login_path
    end 
  end

  def signup
  end

  def signin
  end

  def about
  end
end
