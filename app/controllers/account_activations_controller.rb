class AccountActivationsController < ApplicationController
  def edit
    artist = Artist.find_by(activation_token: params[:id])
    if artist
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
