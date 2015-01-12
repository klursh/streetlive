class Artist < ActiveRecord::Base
  has_many :users,    dependent: :nullify
  has_many :messages, dependent: :destroy
  has_many :movies,   dependent: :destroy

  validates :name,         presence: true
  validates :email,        presence: true
  validates :view_count,   presence: true,
                           numericality: { greater_than_or_equal_to: 0 }
end
