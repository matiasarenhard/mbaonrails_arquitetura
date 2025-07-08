class CoinLog < ApplicationRecord
  include SoftDeletable
  belongs_to :coin

  validates :coin, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
