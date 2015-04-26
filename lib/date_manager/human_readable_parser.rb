class HumanReadableParser

  def self.to_human_readable_date(start_date, finish_date, language = {})
    load_translation(language)["long_readable_format"] % { first_date: "#{start_date.strftime("%B %d, %Y %A")}", last_date: "#{finish_date.strftime("%B %d, %Y %A")}" }
  end

  def self.days_between_dates(days, language = {})
    load_translation(language)["days_between_dates"] % { total_days: days }
  end

  private

    def self.load_translation(language)
      # Loads translation.yml
      if not language.empty?
        @translation ||= YAML.load_file("lib/translations/translation.yml")[language]
      else
        @translation ||= YAML.load_file("lib/translations/translation.yml")['en']
      end
    end

end