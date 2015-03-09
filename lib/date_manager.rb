require 'date'
require 'date_manager/version'
require 'date_manager/date_parser'

class DateManager
  def initialize(start_date, finish_date, format = {})
    @start_date, @finish_date = DateParser.new(start_date, finish_date, format).parse
    @format = format
  end
end