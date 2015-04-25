class HumanReadableParser
  #"Date range between #{@start_date.strftime("%B %d, %Y %A")} and #{@finish_date.strftime("%B %d, %Y %A")}"
  def self.to_human_readable_date(start_date, finish_date)
    "Date range between #{start_date.strftime("%B %d, %Y %A")} and #{finish_date.strftime("%B %d, %Y %A")}"
  end
end