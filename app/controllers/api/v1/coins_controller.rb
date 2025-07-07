class Api::V1::CoinsController < Api::V1::ApplicationController
  before_action :set_coin, only: %i[ show update destroy ]

  def index
    @coins = Coin.all

    render json: @coins
  end

  def show
    render json: @coin
  end

  def create
    @coin = Coin.new(coin_params)

    if @coin.save
      render json: @coin, status: :created, location: @coin
    else
      render json: @coin.errors, status: :unprocessable_entity
    end
  end

  def update
    if @coin.update(coin_params)
      render json: @coin
    else
      render json: @coin.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @coin.destroy!
  end

  private

  def set_coin
    @coin = Coin.find(params.expect(:id))
  end

  def coin_params
    params.expect(coin: [ :name, :symbol ])
  end
end
