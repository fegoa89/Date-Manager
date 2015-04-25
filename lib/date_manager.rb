require 'date'
require 'date_manager/version'
require 'date_manager/date_parser'
require 'date_manager/human_readable_parser'

class DateManager

  attr_accessor :start_date, :finish_date, :format

  def initialize(start_date, finish_date, format = {})
    @start_date, @finish_date = initialize_date_parser(start_date, finish_date, format).parse
    @format = initialize_date_parser(start_date, finish_date, format).format
  end

  def valid_date_range?
    # Compares if the start_date is lower than finish_date
    @start_date < @finish_date
  end

  def days_between_dates
    if valid_date_range?
      @finish_date.mjd - @start_date.mjd
    end
  end

  def months_between_dates
    if valid_date_range?
      (@finish_date.year * 12 + @finish_date.month) - (@start_date.year * 12 + @start_date.month)
    end
  end

  def years_between_dates
    if valid_date_range?
      @finish_date.year - @start_date.year
    end
  end

  def start_date_leap_year?
    # Determines if a year is a leap year
    Date.leap?( @start_date.year )
  end

  def finish_date_leap_year?
    # Determines if a year is a leap year
    Date.leap?( @finish_date.year )
  end

  def differences_between_dates
    # Returns a hash that includes the quantity of years, months and days between
    { years: years_between_dates, months: months_between_dates, days: days_between_dates }
  end

  def human_readable_format
    # returns a string with start_date and finish_date object in a human readable way
    # "Date range between #{@start_date.strftime("%B %d, %Y %A")} and #{@finish_date.strftime("%B %d, %Y %A")}"
    HumanReadableParser.to_human_readable_date(@start_date, @finish_date)
  end

  private

  def initialize_date_parser(start_date, finish_date, format)
    DateParser.new(start_date, finish_date, format)
  end

end