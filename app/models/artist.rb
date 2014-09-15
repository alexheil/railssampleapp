class Artist < ActiveRecord::Base
  has_attached_file :cover_img, styles: { cover: '975x366>' }
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  before_save :downcase_email, :downcase_username
  validates :username, presence: true, length: { maximum: 50 }, if: :username
  validates :artist_name, presence: true, length: { maximum: 50 }, if: :artist_name
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, if: :email
  has_secure_password
  validates :password, length: { minimum: 6 }, if: :password
  validates :terms_of_service, acceptance: true, if: :terms_of_service
  validates_attachment_content_type :cover_img, :content_type => ["image/jpg", "image/jpeg", "image/png"], if: :cover_img

  # Returns the hash digest of the given string.
  def Artist.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def Artist.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a artist in the database for use in persistent sessions.
  def remember
    self.remember_token = Artist.new_token
    update_attribute(:remember_digest, Artist.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a artist.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Activates an account.
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    ArtistMailer.account_activation(self).deliver
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = Artist.new_token
    update_attribute(:reset_digest,  Artist.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    ArtistMailer.password_reset(self).deliver
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Converts username to lower-case.
    def downcase_username
      self.username = username.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token = Artist.new_token
      self.activation_digest = Artist.digest(activation_token)
    end
end
