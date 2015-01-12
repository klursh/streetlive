class User < ActiveRecord::Base
  belongs_to :artist
  belongs_to :scout
  has_many :sent_messages,
         class_name: "Message", foreign_key: "sender_id", dependent: :nullify 

  validates :email,      presence: true
  validates :name,       presence: true
  validates :google_uid, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable, :omniauthable

  rolify

  def refresh_token_if_expired
    return unless token_expired?

    response = RestClient.post(
      "https://accounts.google.com/o/oauth2/token",
      client_id:     Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      refresh_token: self.google_refresh_token,
      grant_type:    "refresh_token")
    refreshhash = JSON.parse(response.body)

    self.google_token = refreshhash['access_token']
    self.expires_at   = DateTime.now + refreshhash["expires_in"].to_i.seconds
    self.save
  end
  
  def token_expired?
    Time.at(self.expires_at) < Time.now
  end

  def self.find_for_google_oauth2(auth)
    User.where(google_uid: auth.uid).first
  end

end
