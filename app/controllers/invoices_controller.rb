class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user_id = 1
    @invoice.save

    render json: @invoice.id
  end

  private
    def invoice_params
      params.require(:invoice).permit(:year)
    end
end
