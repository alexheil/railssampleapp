class MicropostsController < ApplicationController
  before_action :logged_in_artist, only: [:create, :destroy]
  before_action :correct_artist,   only: :destroy

  def create
    @micropost = current_artist.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Status updated!"
      redirect_to current_artist
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Status deleted"
    redirect_to current_artist
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_artist
      @micropost = current_artist.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
