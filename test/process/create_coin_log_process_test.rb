require "test_helper"

class CreateCoinLogProcessTest < ActiveSupport::TestCase
  test "creates a coin log with valid fixture coin" do
    coin = coins(:bitcoin)
    result = CreateCoinLogProcess.call(coin_id: coin.id, price: 123)

    assert result.success?
    coin_log = result.value[:coin_log]
    assert_equal coin, coin_log.coin
    assert_equal 123, coin_log.price.to_d
  end

  test "fails if coin does not exist" do
    result = CreateCoinLogProcess.call(coin_id: -1, price: 100)
    assert result.failure?
    assert_equal :invalid_input, result.type
    assert_includes result.value[:input].errors[:coin_id], "not found"
  end

  test "fails if price is missing" do
    coin = coins(:bitcoin)
    result = CreateCoinLogProcess.call(coin_id: coin.id, price: nil)
    assert result.failure?
    assert_equal :invalid_input, result.type
    assert_includes result.value[:input].errors[:price], "can't be blank"
  end
end
