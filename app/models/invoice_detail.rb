class InvoiceDetail < ApplicationRecord
  belongs_to :invoice
  belongs_to :resident

  validates_presence_of :invoice_id, :resident_id, :state

  def total
    (kaltwasser + warmwasser + heizung + strom + abfall
      + versicherung + steuer + niederschlag)
  end

  def to_pdf
    pdf = Prawn::Document.new

    pdf.font "Helvetica"
    pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 

    pdf.grid([0,0], [1,1]).bounding_box do 
      pdf.text 'Rechnung', :size => 18
      # pdf.text '', :align => :left
      pdf.text "Date: #{Date.today.to_s}", :align => :left
      pdf.move_down 10
      pdf.text "#{resident.name}"
      pdf.text "#{resident.street}"
      pdf.text "#{resident.plz} #{resident.location}"
      pdf.text "#{resident.email}"
    end

    pdf.grid([0,3.6], [1,4]).bounding_box do 
      pdf.move_down 10
      pdf.text "#{resident.name}"
      pdf.text "#{resident.street}"
      pdf.text "#{resident.plz} #{resident.location}"
      pdf.text "#{resident.email}"
    end

    pdf.text "Details of Invoice", :style => :bold_italic
    pdf.stroke_horizontal_rule


    pdf.move_down 10

    attrs = ['kaltwasser', 'warmwasser', 'heizung', 'strom', 'abfall', 
      'versicherung', 'steuer', 'niederschlag']

    items = [["ID","Beschreibung", "Preis"]]
    items += attrs.each_with_index.map do |attr, i|
      [
        i + 1,
        attr,
        self[attr],
      ]
    end
    items += [["", "Total", total]]


    pdf.table items, :header => true, 
      :column_widths => { 0 => 50, 1 => 350, 3 => 100}, :row_colors => ["d2e3ed", "FFFFFF"] do
        style(columns(3)) {|x| x.align = :right }
    end

    pdf.render_file "invoice.pdf"
  end
end
