class Api::V1::CoinLogsController < Api::V1::ApplicationController
  def index
    query = CoinLogQuery.new(coin_id: params[:coin_id], date_start: params[:date_start], date_end: params[:date_end])
    pagy, coin_logs = pagy(query.call)
    render json: { coin_logs: coin_logs, pagy: pagy }
  end

  def create
    result = CreateCoinLogProcess.call(coin_id: coin_params[:coin_id], price: coin_params[:price])

    if result.success?
      NotifyLowPriceJob.perform_now(result.value[:coin_log][:price])
      render json: result.value, status: :created
    else
      render json: { errors: result.failure }, status: :unprocessable_entity
    end
  end

  private

  def coin_params
    params.require(:coin_log).permit(:coin_id, :price)
  end
end
