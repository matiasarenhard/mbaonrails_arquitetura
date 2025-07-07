require "test_helper"

class CoinTest < ActiveSupport::TestCase
  test "bitcoin fixture is valid" do
    bitcoin = coins(:bitcoin)
    assert bitcoin.valid?
    assert_equal "Bitcoin", bitcoin.name
    assert_equal "BTC", bitcoin.symbol
  end

  test "ethereum fixture is valid" do
    ethereum = coins(:ethereum)
    assert ethereum.valid?
    assert_equal "Ethereum", ethereum.name
    assert_equal "ETH", ethereum.symbol
  end

  test "should require a name" do
    coin = Coin.new(symbol: "NEW")
    assert_not coin.valid?
    assert_includes coin.errors[:name], "can't be blank"
  end

  test "should require a symbol" do
    coin = Coin.new(name: "NewCoin")
    assert_not coin.valid?
    assert_includes coin.errors[:symbol], "can't be blank"
  end

  test "should enforce unique name" do
    duplicate = Coin.new(name: "Bitcoin", symbol: "BTC2")
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:name], "has already been taken"
  end

  test "should enforce unique symbol" do
    duplicate = Coin.new(name: "Bitcoin2", symbol: "BTC")
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:symbol], "has already been taken"
  end
end