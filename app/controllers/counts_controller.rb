class CountsController < ApplicationController
  def index
    if current_user.current_invoice_id

    else
      redirect_to invoices_path, alert: 'Bitte selektieren Sie zuerst eine Rechnung.'
    end
  end
end
