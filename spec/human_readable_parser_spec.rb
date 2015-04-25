require 'date_manager'

describe HumanReadableParser do
  describe '.to_human_readable_date' do
    subject { DateManager.new( '2012/02/02', '2012/02/03' ) }

    context "giving two DateTime object" do
      it "should return an human readable string containing date, month and year" do
        expected_string = "Date range between February 02, 2012 Thursday and February 03, 2012 Friday"
        expect(HumanReadableParser.to_human_readable_date(subject.start_date, subject.finish_date)).to eq(expected_string)
      end
    end
  end
end