class Count < ApplicationRecord
  belongs_to :meter
  belongs_to :invoice

  def self.find_or_create_counts(user_id)
    meters = Meter.where(user_id: user_id)
    meters.map do |m|
      count = Count.where(meter_id: m.id).select {|c| c.date.year == Date.new.year}
      if count.nil?
        count = Count.new
        count.meter_id = m.id
      end
      count
    end
  end

end
