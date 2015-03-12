class DateParser
  # Valid date formats by country - based on https://en.wikipedia.org/wiki/Date_format_by_country#Listing
  # Dates formats
  # MDY -> mm/dd/yyyy  Date.strptime("6/15/2012", '%m/%d/%Y') - ^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$
  # DMY -> dd/mm/yyyy  Date.strptime("15/6/2012", '%d/%m/%Y') - ^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$
  # YMD -> yyyy/mm/dd  Date.strptime("2012/6/15", '%Y/%m/%d') - ^\d{4}(-|.|\/)\d{2}(-|.|\/)\d{2}$ with seconds '^\d{4}(-|.|\/)\d{2}(-|.|\/)\d{2} \d{2}:\d{2}:\d{2}$/', '2008-09-01 12:35:45'
  # DateParser.new('02/02/2012','02/02/2013', 'DMY')
  attr_accessor :start_date, :finish_date

  OTHER_COMPONENT_SEPARATOR = {'.' => '/', '-' => '/'}
  DATE_FORMAT               = ['MDY', 'DMY', 'YMD']

  # TODO date format hash with structure {format: 'MDY , structure: '%m/%d/%Y' }
  def initialize(start_date, finish_date, format)
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
    DATE_FORMAT.include?(@format)
  end

  def get_format(format)
    format.nil? ? 'YMD' : format.upcase
  end

  def has_correct_structure?(regex)
    @start_date =~ regex && @start_date =~ regex
  end

  def parse_date
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
    if has_correct_structure?(date_format[:regex])
      clean_date_separator
      convert_to_date_object(date_format[:structure])
    end
  end

  def clean_date_separator
    # TODO
  end

  def date_format_structure
    {
      mdy: { structure: '%m/%d/%Y', regex: /^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$/ },
      dmy: { structure: '%d/%m/%Y', regex: /^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$/ },
      ymd: { structure: '%Y/%m/%d', regex: /^\d{4}(-|.|\/)\d{2}(-|.|\/)\d{2}$/ }
    }
  end

  def convert_to_date_object(structure)
    [ Date.strptime(@start_date, structure), Date.strptime(@finish_date, structure) ]
  end

end