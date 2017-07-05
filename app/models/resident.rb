class Resident < ApplicationRecord
  belongs_to :flat
  belongs_to :user

  scope :by_user, lambda { |user_id| where(user_id: user_id) }
  scope :current, lambda { where(move_out: nil) }
  scope :of_year, lambda { |year| where("move_in <= ?", Date.new(year, 12, 31)).where("move_out >= ? OR move_out IS ?", Date.new(year, 1, 1), nil) }


  def year_share(year)
    first_day = Date.new(year, 1, 1)
    last_day = Date.new(year, 12, 31)
    if(move_in < first_day)
      start = first_day
    elsif move_in > last_day
      return 0
    else
      start = move_in
    end

    if(move_out.nil? || move_out > last_day)
      ende = last_day
    elsif move_out < first_day
      return 0
    else
      ende = move_out
    end
    
    return ((ende - start) / (leap?(year) ? 366 : 365).to_f)
  end

  def leap?(year)
    if (year % 400) == 0 || ((year % 4) == 0 && (year % 100) != 0)
      return true;
    end

    false
  end
end
