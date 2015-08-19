class Api::V1::TransactionsController < ApplicationController
  respond_to :json
  before_filter :sanitize_params, except: [:show, :index, :destroy]

  def create
    trade = Trade.create(proposed_trade_params)
    respond_with :api, :v1, trade
  end

  def index
    respond_with Trade.all
  end

  def show
    respond_with Trade.find(params[:id].to_i)
  end

  def update
    respond_with :api, :v1, Trade.update(params[:id].to_i, proposed_trade_params)
  end

  def destroy
    respond_with Trade.destroy(params[:id])
  end

  private

  def sanitize_params
    params["trade"]["status"] = params["trade"]["status"].to_i
  end

  def proposed_trade_params
    params.require(:trade).permit(:status,
                                :item_id,
                                :user_id,
                                :message)
  end

end
