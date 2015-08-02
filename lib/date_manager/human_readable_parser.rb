class HumanReadableParser

  def self.to_human_readable_date(start_date, finish_date, language = {})
    load_translation(language)["long_readable_format"] % { first_date: "#{start_date.strftime("%B %d, %Y %A")}", last_date: "#{finish_date.strftime("%B %d, %Y %A")}" }
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

end