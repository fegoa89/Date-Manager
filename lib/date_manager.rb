require 'date'
require 'date_manager/version'
require 'date_manager/date_parser'

class DateManager

  attr_accessor :start_date, :finish_date, :format

  def initialize(start_date, finish_date, format = {})
    @start_date, @finish_date = initialize_date_parser(start_date, finish_date, format).parse
    @format = initialize_date_parser(start_date, finish_date, format).format
  end

  def valid_date_range?
    @start_date < @finish_date
  end

  private

  def initialize_date_parser(start_date, finish_date, format)
    DateParser.new(start_date, finish_date, format)
  end

end