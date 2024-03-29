class Api::V1::Invoices::FindController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find_by(invoice_params))
  end

  def index
    render json: InvoiceSerializer.new(Invoice.where(invoice_params))
  end

  private

  def invoice_params
    params.permit(:id, :status, :created_at, :updated_at, :customer_id, :merchant_id)
  end
end
