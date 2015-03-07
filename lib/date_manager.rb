require 'date'
require 'date_manager/version'
require 'date_manager/date_parser'

class DateManager
  def initialize(start_date, finish_date, format)
    @start_date, @finish_date = parse(start_date, finish_date, format)
    @format = format
  end
end