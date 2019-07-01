class Api::V1::InvoiceItems::FindController < ApplicationController
  def show
    if params[:unit_price]
      slice_unit_price
    end
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(invoice_item_params))
  end

  def index
    if params[:unit_price]
      slice_unit_price
    end
    render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_item_params))
  end

  private

  def invoice_item_params
    params.permit(:id, :quantity, :unit_price, :created_at, :updated_at, :invoice_id, :item_id)
  end

  def slice_unit_price
    if params[:unit_price].include? "\""
      params[:unit_price].slice! "\""
      params[:unit_price].slice! "\""
    end
    params[:unit_price] = ((params[:unit_price].to_f)*100).to_i
  end
end
