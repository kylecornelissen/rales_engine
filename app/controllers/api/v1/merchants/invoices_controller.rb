class Api::V1::Merchants::InvoicesController < ApplicationController
  def index
    render json: InvoiceSerializer.new(Invoice.where(merchant:(params[:id])))
  end
end
