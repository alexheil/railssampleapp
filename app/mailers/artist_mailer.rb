class ArtistMailer < ActionMailer::Base
  default from: "noreply@beatsrealm.com"

  def account_activation(artist)
    @artist = artist
    mail to: artist.email, subject: "Account activation"
  end

  def password_reset(artist)
    @artist = artist
    mail to: artist.email, subject: "Password reset"
  end
end
