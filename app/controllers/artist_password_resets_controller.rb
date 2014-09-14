class ArtistPasswordResetsController < ApplicationController
  before_action :get_artist, only: [:edit, :update]

  def new
  end

  def create
    @artist = Artist.find_by(email: params[:password_reset][:email].downcase)
    if @artist
      @artist.create_reset_digest
      @artist.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @artist.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_path
    elsif @artist.update_attributes(artist_params)
      flash[:success] = "Password has been reset."
      log_in @artist
      redirect_to @artist
    else
      render :edit
    end
  end

  private

    def artist_params
      params.require(:artist).permit(:password, :password_confirmation)
    end

    def get_artist
      @artist = Artist.find_by(email: params[:email])
      unless @artist && @artist.authenticated?(:reset, params[:id])
        redirect_to root_url
      end
    end
end
