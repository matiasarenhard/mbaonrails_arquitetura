require "test_helper"

class CoinLogQueryTest < ActiveSupport::TestCase
  setup do
    @bitcoin = Coin.create!(name: "Bitcoin#{SecureRandom.hex(4)}", symbol: "BTC#{rand(1000)}", created_at: 5.days.ago)
    @ethereum = Coin.create!(name: "Ethereum#{SecureRandom.hex(4)}", symbol: "ETH#{rand(1000)}", created_at: 4.days.ago)

    @bitcoin_log = CoinLog.create!(coin: @bitcoin, price: 100.0, created_at: 3.days.ago)
    @ethereum_log = CoinLog.create!(coin: @ethereum, price: 200.0, created_at: 2.days.ago)
  end

  test "returns no coin_logs when date_start is in the future" do
    result = CoinLogQuery.new(coin_id: @bitcoin.id, date_start: 1.year.from_now).call
    assert_empty result
  end

  test "returns coin_logs created after date_start" do
    date_start = 5.days.ago
    result = CoinLogQuery.new(coin_id: @bitcoin.id, date_start: date_start).call
    assert_includes result, @bitcoin_log

    result_eth = CoinLogQuery.new(coin_id: @ethereum.id, date_start: date_start).call
    assert_includes result_eth, @ethereum_log
  end

  test "returns coin_logs created between date_start and date_end" do
    date_start = 4.days.ago
    date_end = 1.day.ago

    result = CoinLogQuery.new(coin_id: @bitcoin.id, date_start: date_start, date_end: date_end).call
    assert_includes result, @bitcoin_log

    result_eth = CoinLogQuery.new(coin_id: @ethereum.id, date_start: date_start, date_end: date_end).call
    assert_includes result_eth, @ethereum_log
  end

  test "includes bitcoin_log if it was created before date_end" do
    date_end = @bitcoin_log.created_at + 1.second
    result = CoinLogQuery.new(coin_id: @bitcoin.id, date_end: date_end).call
    assert_includes result, @bitcoin_log
  end

  test "does not include bitcoin_log if it was created after date_end" do
    date_end = @bitcoin_log.created_at - 1.second
    result = CoinLogQuery.new(coin_id: @bitcoin.id, date_end: date_end).call
    assert_not_includes result, @bitcoin_log
  end
end
