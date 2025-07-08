class Coin < ApplicationRecord
  include SoftDeletable
  has_many :coin_logs, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :symbol, presence: true, uniqueness: true
end
