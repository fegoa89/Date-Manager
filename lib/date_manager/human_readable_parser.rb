class HumanReadableParser

  def self.to_human_readable_date(start_date, finish_date, language = {})
    load_translation(language)["long_readable_format"] % { first_date: format_date(start_date), last_date: format_date(finish_date) }
  end

  def self.days_between_dates(days, language = {})
    load_translation(language)["days_between_dates"] % { total_days: days }
  end

  def self.months_between_dates(months, language = {})
    load_translation(language)["months_between_dates"] % { total_months: months }
  end

  private

    def self.load_translation(language)
      # Loads translation.yml
      if not language.empty?
        @file ||= YAML.load_file("lib/translations/translation.yml")[language]
      else
        @sfile ||= YAML.load_file("lib/translations/translation.yml")['en']
      end
    end

    def self.format_date(date)
      "#{date.strftime("%A, " + ordinalize(date.day) + " of %B %Y")}"
    end


    def self.ordinalize(number)
      abs_number = number.to_i.abs

      if (11..13).include?(abs_number % 100)
        "#{number}th"
      else
        case abs_number % 10
          when 1; "#{number}st"
          when 2; "#{number}nd"
          when 3; "#{number}rd"
          else    "#{number}th"
        end
      end
    end

end