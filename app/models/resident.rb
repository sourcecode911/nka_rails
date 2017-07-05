class Resident < ApplicationRecord
  belongs_to :flat
  belongs_to :user

  validates_presence_of :persons, :flat_id, :move_in

  scope :by_user, lambda { |user_id| where(user_id: user_id) }
  scope :current, lambda { where(move_out: nil) }
  scope :of_year, lambda { |year| where("move_in <= ?", Date.new(year, 12, 31)).where("move_out >= ? OR move_out IS ?", Date.new(year, 1, 1), nil) }

  def year_share(year)
    ((last_day(year) - first_day(year)) / (leap?(year) ? 366 : 365).to_f)
  end

  def leap?(year)
    if (year % 400) == 0 || ((year % 4) == 0 && (year % 100) != 0)
      return true;
    end

    false
  end

  def usage(expense_type, year)
    flat.meters.where(expense_type: expense_type).sum do |m|
      return (m.count_at(last_day(year)) - m.count_at(first_day(year)))
    end
  end

  def first_day(year)
    first_day = Date.new(year, 1, 1)
    last_day = Date.new(year, 12, 31)

    if(move_in <= first_day)
      return Date.new(year-1, 12, 31)
    elsif move_in > last_day
      return 0
    end

    move_in
  end

  def last_day(year)
    first_day = Date.new(year-1, 12, 31)
    last_day = Date.new(year, 12, 31)
    
    if(move_out.nil? || move_out > last_day)
      return last_day
    elsif move_out < first_day
      return 0
    end

    move_out
  end
end
