class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to current_artist
    else
      render 'new'
    end
  end

  def create
    artist = Artist.find_by(email: params[:session][:email].downcase)
    if artist && artist.authenticate(params[:session][:password])
      if artist.activated?
        log_in artist
        params[:session][:remember_me] == '1' ? remember(artist) : forget(artist)
        redirect_back_or artist
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    forget(current_artist)
    session.delete(:artist_id)
    @current_artist = nil
    redirect_to root_url
  end
end
