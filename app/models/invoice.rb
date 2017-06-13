class Invoice < ApplicationRecord
  belongs_to :user
  has_many :invoice_details, dependent: :destroy
  has_many :counts
  has_many :flats, through: :user
  has_many :meters, through: :flats

  validates_presence_of :user_id, :year, :state
  validates_uniqueness_of :year, scope: :user_id

  accepts_nested_attributes_for :flats

  def finalize
    flats.each do |f|
      detail = invoice_details.build
      detail.resident_id = f.residents.first.id
      detail.kaltwasser = wasserkosten(f)
      detail.warmwasser = warmwasserkosten(f)
      detail.abfall = abfallkosten(f)
      detail.heizung = heizungskosten(f)
      detail.versicherung = versicherungskosten(f)
      detail.steuer = grundsteuerkosten(f)
      detail.strom = stromkosten
    end

    save
  end

  def wasserkosten(flat)
    wasser_anteil = Meter.get_share(self, flat, 0)
    return (wasser_anteil * wasser).round(2)
  end

  def heizungskosten(flat)
    heizkosten = gesamt_heizkosten * Meter.heizungs_share(id)
    heizung_anteil = Meter.get_share(self, flat, 2)
    return (heizkosten * heizung_anteil).round(2)
  end

  def warmwasserkosten(flat)
    warmwasser_kosten = gesamt_heizkosten * Meter.warmwasser_share(id)
    warmwasser_anteil = Meter.get_share(self, flat, 1)
    return (warmwasser_kosten * warmwasser_anteil).round(2)
  end

  def abfallkosten(flat)
    total_residents = flats.sum {|f| f.residents.length}
    share = flat.residents.length / total_residents
    return (abfall * share).round(2)
  end

  def versicherungskosten(flat)
    total_space = flats.sum {|f| f[:area]}
    share = (flat.area / total_space)
    return (versicherung * share).round(2)
  end

  def grundsteuerkosten(flat)
    share = flat.ownership / 100
    return (grundsteuer * share).round(2)
  end

  def niederschlagskosten
    return (niederschlag / flats.length).round(2)
  end

  def stromkosten
    return (gesamt_strom / flats.length).round(2)
  end

  def gesamt_heizkosten
    erdgas + kamin + wartung + reinigung + gesamt_strom
  end
end
