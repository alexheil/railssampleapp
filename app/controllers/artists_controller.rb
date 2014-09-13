class ArtistsController < ApplicationController

  before_action :logged_in_artist, only: [:edit, :update, :destroy]
  before_action :correct_artist, only: [:edit, :update]
  before_action :admin_artist, only: :destroy

  def index
    @artists = Artist.where(activated: true).paginate(page: params[:page])
  end

  def new
    if logged_in?
      redirect_to current_artist
    end
    @artist = Artist.new
  end

  def show
    @artist = Artist.find(params[:id])
    @micropost = current_artist.microposts.build if logged_in?
    @microposts = @artist.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @artist.activated?
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      @artist.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update_attributes(artist_params)
      flash[:success] = "Profile updated"
      redirect_to @artist
    else
      render 'edit'
    end
  end

  def destroy
    Artist.find(params[:id]).destroy
    flash[:success] = "Artist deleted"
    redirect_to artists_url
  end

  private

    def artist_params
      params.require(:artist).permit(:username, :email, :password, :password_confirmation, :genre, :location, :sounds_like, :biography, :artist_name, :terms_of_service)
    end

    def correct_artist
      @artist = Artist.find(params[:id])
      redirect_to(root_url) unless current_artist?(@artist)
    end

    def admin_artist
      redirect_to(root_url) unless current_artist.admin?
    end
end
