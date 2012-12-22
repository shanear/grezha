class Child < ActiveRecord::Base
  AGE_UNKNOWN_YEAR = 1

  attr_accessible :name, :age

  belongs_to :contact

  validates_presence_of :name

  def to_s
    "#{name} (#{age})"
  end

  def birthday=(options = {})
    if options[:month] && options[:day]
      self.birth_date ||= DateTime.new(year: AGE_UNKNOWN_YEAR)
      self.birth_date = birth_date.change(month: options[:month], day: options[:day])
    end
  end

  def age
    if age_known?
      birthday_this_year = (birth_date.month - DateTime.now.month) > 0 &&
                           (birth_date.day - DateTime.now.day) > 0
      (DateTime.now.year - birth_date.year) - (birthday_this_year ? 1 : 0)
    end
  end

  def age=(value)
    if value
      value = value.to_i
      year = DateTime.now.year - value
    else
      year = AGE_UNKNOWN_YEAR
    end

    self.birth_date ||= DateTime.now
    self.birth_date = birth_date.change(year: year)
  end

  def age_known?
    birth_date && (birth_date.year != AGE_UNKNOWN_YEAR)
  end
end
