require 'date_manager'

describe HumanReadableParser do

  subject { DateManager.new( '2012/02/01', '2012/02/03' ) }

  describe '.to_human_readable_date' do
    context "giving two DateTime object" do
      it "should return an human readable string containing date, month and year" do
        expected_string = "First date : Wednesday, 1st of February 2012 - Second date : Friday, 3rd of February 2012"
        expect(HumanReadableParser.to_human_readable_date(subject.start_date, subject.finish_date)).to eq(expected_string)
      end
    end

  end

  describe '.days_between_dates' do
    context "giving two DateTime object" do
      it "should return an human readable string containing the days in between" do
        expected_string = "2 days"
        expect(HumanReadableParser.days_between_dates(subject.days_between_dates)).to eq(expected_string)
      end
    end

    context "giving two DateTime object and a language" do
      it "should return an human readable string containing the days in between translated to spanish" do
        expected_string = "2 dias"
        expect(HumanReadableParser.days_between_dates(subject.days_between_dates, 'es')).to eq(expected_string)
      end
    end
  end

  describe '.months_between_dates' do
    context "giving two DateTime object" do
      it "should return an human readable string containing the months in between" do
        expected_string = "0 months"
        expect(HumanReadableParser.months_between_dates(subject.months_between_dates)).to eq(expected_string)
      end
    end

    context "giving two DateTime object and a language" do
      it "should return an human readable string containing the months in between" do
        expected_string = "0 meses"
        expect(HumanReadableParser.months_between_dates(subject.months_between_dates, 'es')).to eq(expected_string)
      end
    end
  end
end