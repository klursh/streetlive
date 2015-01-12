class Message < ActiveRecord::Base
  belongs_to :artist
  belongs_to :sender,      class_name: "User"
  belongs_to :responds_to, class_name: "Message"
  has_many :responses, dependent: :nullify,
                       class_name: "Message", foreign_key: "responds_to_id"

  validates :artist,  presence: true
  validates :sender,  presence: true
  validates :content, presence: true
  validate :responds_to_existent_message?
  validate :responds_to_same_artists_message?
  validates_with MessageMustNotRespondToItselfValidator

  private
    def responds_to_existent_message?
      return if responds_to_id.blank?
      unless Message.exists?(responds_to_id)
        errors.add(:responds_to, "can't refer to non-existent message")
      end
    end
    
    def responds_to_same_artists_message?
      return if responds_to_id.blank?
      unless responds_to.artist == artist
        errors.add(:responds_to, "can't refer to message owned another artist")
      end
    end

end
