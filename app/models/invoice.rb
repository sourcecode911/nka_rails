class Invoice < ApplicationRecord
  belongs_to :user
  has_many :invoice_details, dependent: :destroy
  has_many :counts
  has_many :flats, through: :user
  has_many :residents, through: :flats
  has_many :meters, through: :flats

  validates_presence_of :user_id, :year, :state
  validates_uniqueness_of :year, scope: :user_id

  accepts_nested_attributes_for :flats

  def invoice_valid?
    errors.add('Betriebskosten', 'müssen ausgefüllt sein') unless (wasser || gesamt_strom || abfall || versicherung ||
        grundsteuer || reinigung || niederschlag || kamin || abwasser || wartung || erdgas)
    errors.add('Wamwasserzähler',  'gesamt muss vorhanden sein') unless Meter.where(expense_type: 5, user_id: user_id).size > 0
    residents.of_year(year).each {|r| resident_valid?(r) }

    !errors.any?
  end

  def resident_valid?(resident)
    resident.flat.meters.each do |m|
      if m.counts.where(date: resident.first_day(year)).size == 0 && resident.first_day(year) != Date.new(year-1, 12, 31)
        errors.add("Zählerstand für Zähler #{m.name}", "ist am #{resident.first_day(year)} nicht ausgefüllt")
      end

      errors.add("Zählerstand für Zähler #{m.name}", "ist am #{resident.last_day(year)} nicht ausgefüllt") if m.counts.where(date: resident.last_day(year)).size == 0
    end
  end

  def finalize
    return false unless invoice_valid?

    invoice_details.delete_all
    residents.of_year(year).each do |r|
      detail = invoice_details.build
      detail.resident_id = r.id
      detail.kaltwasser = wasserkosten(r)
      detail.warmwasser = warmwasserkosten(r)
      detail.abfall = abfallkosten(r)
      detail.heizung = heizungskosten(r)
      detail.versicherung = versicherungskosten(r)
      detail.steuer = grundsteuerkosten(r)
      detail.niederschlag = niederschlagskosten(r)
      detail.strom = stromkosten(r)
    end
    save
  end

  def wasserkosten(resident)
    return (resident_share(0, resident) * (wasser + abwasser)).round(2)
  end

  def heizungskosten(resident)
    heizkosten = gesamt_heizkosten * heizungs_share
    return (heizkosten * resident_share(2, resident)).round(2)
  end

  def warmwasserkosten(resident)
    warmwasser_kosten = gesamt_heizkosten * warmwasser_share
    return (warmwasser_kosten * resident_share(1, resident)).round(2)
  end

  def abfallkosten(resident)
    share = resident.persons / Resident.of_year(year).by_user(user_id).size
    return (abfall * share).round(2)
  end

  def versicherungskosten(resident)
    total_space = flats.sum {|f| f[:area]}
    share = (resident.flat.area / total_space.to_f)
    return (versicherung * share * resident.year_share(year)).round(2)
  end

  def grundsteuerkosten(resident)
    share = resident.flat.ownership / 100.to_f
    return (grundsteuer * share * resident.year_share(year)).round(2)
  end

  def niederschlagskosten(resident)
    return ((niederschlag.to_f / flats.length) * resident.year_share(year)).round(2)
  end

  def stromkosten(resident)
    return ((gesamt_strom.to_f / flats.length) * resident.year_share(year)).round(2)
  end

  def gesamt_heizkosten
    (erdgas + kamin + wartung + reinigung + gesamt_strom).to_f
  end

  # Liefert die allgemeinen Zähler, welche keiner bestimmten Wohnung zugeordnet sind.
  def common_meters
    Meter.where(flat_id: nil, user_id: user_id)
  end

  # Liefert den gesamten Zählerstand für einen Kostentyp zu Beginn der Abrechnung.
  def last_count(expense_type)
    meters.where(expense_type: expense_type, user_id: user_id).sum do |m|
      old_count = m.count_at(Date.new(year - 1, 12, 31))
      if old_count == 0 
        return m.initial_count
      end 
      old_count
    end
  end

  # Liefert den gesamten Zählerstand für einen Kostentyp zum Ende der Abrechnung.
  def current_count(expense_type)
    meters.where(expense_type: expense_type, user_id: user_id).sum do |m|
      m.count_at(Date.new(year, 12, 31))
    end
  end

  # Liefert den gesamten Verbrauch für einen Kostentyp im aktuellen Abrechnungsjahr.
  def total_usage(expense_type)
    current_count(expense_type) - last_count(expense_type)
  end

  # Liefert den Anteil für einen bestimmten Kostentyp eines Bewohners im aktuellen Abrechnungsjahr.
  def resident_share(expense_type, resident)
    resident.usage(expense_type, year) / total_usage(expense_type)
  end

  def warmwasser_share
    total_usage(5)/ (total_usage(2) + total_usage(5))
  end

  def heizungs_share
    total_usage(2)/ (total_usage(2) + total_usage(5))
  end
end
