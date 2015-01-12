class Scout < ActiveRecord::Base
  has_many :users, dependent: :nullify

  validates :company,    presence: true
  validates :last_name,  presence: true
  validates :first_name, presence: true
  validates :zip,        presence: true,
                         format: { with: /\A[0-9]{7}\z/,
                                   message: "数字7桁で入力してください。" }
  validates :prefecture, presence: true
  validates :city,       presence: true
  validates :address,    presence: true
  validates :email,      presence: true
  validates :phone,      presence: true,
                         format: { with: /\A[0-9]+\z/,
                                   message: "数字のみ入力できます。" }

  def name
    "#{last_name} #{first_name}"
  end
end
