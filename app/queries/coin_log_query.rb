class CoinLogQuery
  attr_reader :coin_id, :date_start, :date_end

  def initialize(coin_id:, date_start: nil, date_end: nil)
    @coin_id = coin_id
    @date_start = date_start
    @date_end = date_end
  end

  def call
    run
  end

  private

  def run
    coin_logs = CoinLog.where(coin_id: coin_id)
    date_range = build_date_range
    date_range ? coin_logs.where(created_at: date_range) : coin_logs
  end

  def build_date_range
    return full_range if date_start && date_end
    return start_only_range if date_start
    return end_only_range if date_end

    nil
  end

  def full_range
    date_start..date_end
  end

  def start_only_range
    date_start..
  end

  def end_only_range
    ..date_end
  end
end
