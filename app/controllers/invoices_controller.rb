class InvoicesController < ApplicationController
  def index
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    @invoice.save

    render json: @invoice.id
  end
end
