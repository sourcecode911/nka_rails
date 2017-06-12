class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :update, :finalize]

  def index
    @invoices = Invoice.all

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @invoices }
    end
  end

  def show
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user_id = current_user.id

    @invoice.save!

    respond_to do |format|
      format.html { redirect_to invoices_path, notice: "Abrechnung für das Jahr #{@invoice.year} wurde erstellt." }
      format.json { render json: @invoice.id }
    end
  end

  def expenses
    if current_user.current_invoice_id
      @invoice = Invoice.find(current_user.current_invoice_id)
      render 'expenses'
    else
      redirect_to invoices_path, alert: 'Bitte selektieren Sie zuerst eine Rechnung.'
    end
  end

  def counts
    if current_user.current_invoice_id
      @invoice = Invoice.find(current_user.current_invoice_id)
      render 'counts'
    else
      redirect_to invoices_path, alert: 'Bitte seleketieren Sie zuerst eine Rechnung.'
    end
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to expenses_invoices_path, notice: 'Die Abrechnung wurde gespeichert.'
    else
      render 'expenses'
    end
  end

  def finalize
    if @invoice.finalize
      redirect_to invoice_path(@invoice), notice: "Das Jahr #{@invoice.year} wurde abgerechnet."
    else
      render 'index'
    end
  end


  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit( :year, :erdgas, :wartung, :kamin, :reinigung, :strompreis, :stromverbrauch, :gesamt_strom,
                                      :wasser, :abwasser, :niederschlag, :abfall, :grundsteuer, :versichung,
                                      flats_attributes: [ :id, meters_attributes: [ :id, counts_attributes: [ :id, :date, :amount, :meter_id, :invoice_id]] ])
    end


end
