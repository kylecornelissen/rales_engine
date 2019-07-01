class Api::V1::Items::FindController < ApplicationController
  def show
    if params[:unit_price]
      slice_unit_price
    end
    render json: ItemSerializer.new(Item.find_by(item_params))
  end

  def index
    if params[:unit_price]
      slice_unit_price
    end
    render json: ItemSerializer.new(Item.where(item_params))
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id)
  end

  def slice_unit_price
    if params[:unit_price].include? "\""
      params[:unit_price].slice! "\""
      params[:unit_price].slice! "\""
    end
    params[:unit_price] = ((params[:unit_price].to_f)*100).round(2).to_i
  end
end
