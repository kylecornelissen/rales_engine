class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Transaction.where(invoice:(params[:id])))
  end
end
