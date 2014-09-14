class ArtistAccountActivationsController < ApplicationController
  def edit
    artist = Artist.find_by(email: params[:email])
    if artist && !artist.activated? && artist.authenticated?(:activation, params[:id])
      artist.activate
      flash[:success] = "Account activated!"
      log_in artist
      redirect_to artist
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
