module SessionsHelper
  def log_in(artist)
    session[:artist_id] = artist.id
  end

    # Remembers a artist in a persistent session.
  def remember(artist)
    artist.remember
    cookies.permanent.signed[:artist_id] = artist.id
    cookies.permanent[:remember_token] = artist.remember_token
  end

  # Returns the current logged-in artist (if any).
  def current_artist
    if (artist_id = session[:artist_id])
      @current_artist ||= Artist.find_by(id: artist_id)
    elsif (artist_id = cookies.signed[:artist_id])
      artist = Artist.find_by(id: artist_id)
      if artist && artist.authenticated?(:remember, cookies[:remember_token])
        log_in artist
        @current_artist = artist
      end
    end
  end

  def current_artist?(artist)
    artist == current_artist
  end

  def logged_in?
    !current_artist.nil?
  end

  # Forgets a persistent session.
  def forget(artist)
    artist.forget
    cookies.delete(:artist_id)
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

    def store_location
      session[:forwarding_url] = request.url if request.get?
    end
end
