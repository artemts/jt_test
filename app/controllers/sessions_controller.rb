class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where("lower(login) = ?",
                      params[:session][:login].downcase).first
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_url
    else
      flash.now[:danger] = "Invalid login/password combination"
      render "new"
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
