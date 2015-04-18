class DateParser
  # Valid date formats by country - based on https://en.wikipedia.org/wiki/Date_format_by_country#Listing
  # Dates formats
  # MDY -> mm/dd/yyyy  DateTime.parse("6/15/2012", '%m/%d/%Y') - ^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$
  # DMY -> dd/mm/yyyy  DateTime.parse("15/6/2012", '%d/%m/%Y') - ^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$
  # YMD -> yyyy/mm/dd  DateTime.parse("2012/6/15", '%Y/%m/%d') - ^\d{4}(-|.|\/)\d{2}(-|.|\/)\d{2}$ with seconds '^\d{4}(-|.|\/)\d{2}(-|.|\/)\d{2} \d{2}:\d{2}:\d{2}$/', '2008-09-01 12:35:45'
  # DateParser.new('02/02/2012','02/02/2013', 'DMY')
  attr_accessor :start_date, :finish_date, :format

  OTHER_COMPONENT_SEPARATOR = {'.' => '/', '-' => '/'}
  DATE_FORMAT               = ['MDY', 'DMY', 'YMD']

  def initialize(start_date, finish_date, format = '')
    @format      = get_format(format)
    @start_date  = start_date
    @finish_date = finish_date
  end

  def parse
    if valid_country_format_date?
      parse_date
    end
  end

  private

  def valid_country_format_date?
    # Check if the format given is included into the date formats we can handle
    DATE_FORMAT.include?(@format)
  end

  def get_format(format)
    # If there is no format present, automatically assigns 'YMD' date format
    ( format.nil? || format.empty? ) ? 'YMD' : analyze_format_string(format.upcase)
  end

  def analyze_format_string(format)
    DATE_FORMAT.include?(format) ? format : nil
  end

  def has_correct_structure?(regex)
    # Compares the string given for both dates with the regex expresion for
    # this date format
    @start_date =~ regex && @start_date =~ regex
  end

  def parse_date
    # Validates and convert the string based on the date format
    case @format
      when 'MDY'
        validate_string(date_format_structure[:mdy])
      when 'DMY'
        validate_string(date_format_structure[:dmy])
      else
        validate_string(date_format_structure[:ymd])
    end
  end

  def validate_string(date_format)
    # If the structure of the string coincides with the regex expression for this date format
    # then it cleans the string if it contains the dates separated with '.' or '-'
    # and convert it to an Date object
    if has_correct_structure?(date_format[:regex])
      clean_date_separator
      convert_to_date_object(date_format[:structure])
    end
  end

  def clean_date_separator
    @start_date.gsub!('.', '/')  if @start_date.include?('.')
    @start_date.gsub!('-', '/')  if @start_date.include?('-')
    @finish_date.gsub!('.', '/') if @finish_date.include?('.')
    @finish_date.gsub!('-', '/') if @finish_date.include?('-')
  end

  def date_format_structure
    # Hash that contains the structure that this date format has (m - Month, d - Day, Y - Year)
    # for be parsed to a valid Date object.
    # Contains the regular expression for compare the exact position of the day, month
    # and year, depending on the date format
    {
      mdy: { structure: '%m/%d/%Y', regex: /^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$/ },
      dmy: { structure: '%d/%m/%Y', regex: /^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$/ },
      ymd: { structure: '%Y/%m/%d', regex: /^\d{4}(-|.|\/)\d{2}(-|.|\/)\d{2}$/ }
    }
  end

  def convert_to_date_object(structure)
    # Returns two Date objects
    [ DateTime.parse(@start_date, structure), DateTime.parse(@finish_date, structure) ]
  end

end