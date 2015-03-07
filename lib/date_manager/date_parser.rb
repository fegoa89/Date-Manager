# Valid date formats by country - based on https://en.wikipedia.org/wiki/Date_format_by_country#Listing
# Dates formats
# MDY -> mm/dd/yyyy  Date.strptime("6/15/2012", '%m/%d/%Y') - ^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$
# DMY -> dd/mm/yyyy  Date.strptime("15/6/2012", '%d/%m/%Y') - ^\d{2}(-|.|\/)\d{2}(-|.|\/)\d{4}$
# YMD -> yyyy/mm/dd  Date.strptime("2012/6/15", '%Y/%m/%d') - ^\d{4}(-|.|\/)\d{2}(-|.|\/)\d{2}$
#
# Examples
DATE_FORMAT = ['MDY', 'DMY', 'YMD']
# TODO date format hash with structure {format: 'MDY , structure: '%m/%d/%Y' }
def parse(start_date, finish_date, format)
  if valid_format_date?(format)
  end
end

def valid_format_date?(format)
  DATE_FORMAT.include?(format.upcase)
end