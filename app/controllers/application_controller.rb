class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ArtistsHelper

  private

    # Confirms a logged-in artist.
      def logged_in_artist
        unless logged_in?
          store_location
          flash[:danger] = "You need to be logged in to access that page."
          redirect_to login_url
        end
      end
end
