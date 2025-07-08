class CreateCoinLogProcess < Solid::Process
  input do
    attribute :coin_id, :integer
    attribute :price, :decimal

    with_options presence: true do
      validates :coin_id
      validates :price, numericality: { greater_than: 0 }
    end
  end

  def call(attributes)
    rollback_on_failure {
      Given(attributes)
        .and_then(:find_coin)
        .and_then(:create_coin_log)
    }
    .and_expose(:coin_log_created, [ :coin_log ])
  end

  private

  def find_coin(coin_id:, **)
    coin = Coin.find_by(id: coin_id)
    input.errors.add(:coin_id, "not found") unless coin
    input.errors.any? ? Failure(:invalid_input, input:) : Continue(coin:)
  end

  def create_coin_log(coin:, price:, **)
    coin_log = CoinLog.create(coin: coin, price: price)
    return Continue(coin_log:) if coin_log.persisted?

    input.errors.merge!(coin_log.errors)
    Failure(:invalid_input, input:)
  end
end
