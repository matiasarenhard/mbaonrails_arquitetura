class Api::V1::CoinLogsController < Api::V1::ApplicationController
  def create
    result = CreateCoinLogProcess.call(coin_id: coin_params[:coin_id], price: coin_params[:price])

    if result.success?
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
