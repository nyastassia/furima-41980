class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :password,
            format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[\x20-\x7e]+\z/, message: 'is invalid. Include both letters and numbers' }
  validates :name_kanji, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :surname_kanji, presence: true,
                            format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :name_katakana, presence: true,
                            format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :surname_katakana, presence: true,
                               format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :birthday, presence: true

  has_many :items
  # has_many :purchases
end
