class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(item:(params[:id])))
  end
end
