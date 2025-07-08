require "test_helper"

class CoinLogTest < ActiveSupport::TestCase
  test "fixture is valid" do
    coin_log = coin_logs(:bitcoin)
    assert coin_log.valid?
    assert_equal coins(:bitcoin), coin_log.coin
  end

  test "should require a coin" do
    coin_log = CoinLog.new(price: 100)
    assert_not coin_log.valid?
    assert_includes coin_log.errors[:coin], "must exist"
  end

  test "should require a price" do
    coin_log = CoinLog.new(coin: coins(:bitcoin))
    assert_not coin_log.valid?
    assert_includes coin_log.errors[:price], "can't be blank"
  end

  test "should require price to be greater than 0" do
    coin_log = CoinLog.new(coin: coins(:bitcoin), price: 0)
    assert_not coin_log.valid?
    assert_includes coin_log.errors[:price], "must be greater than 0"
  end

  test "should belong to coin" do
    coin_log = coin_logs(:bitcoin)
    assert_respond_to coin_log, :coin
    assert_instance_of Coin, coin_log.coin
  end

  test "should soft delete coin_log" do
    coin_log = CoinLog.create!(coin: coins(:bitcoin), price: 100)
    assert_not coin_log.deleted?
    coin_log.soft_delete
    assert coin_log.deleted?
    assert_not CoinLog.active.exists?(coin_log.id)
  end
end
