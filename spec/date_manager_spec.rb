require 'date_manager'

describe DateManager do

  describe '#initialize' do
    context 'with valid params given' do
      cases = [ { first_date: '2012/02/02', second_date: '2012/02/03' , format: 'YMD', date_structure: '%Y/%m/%d' },
                { first_date: '2012.02.02', second_date: '2012.02.03' , format: 'YMD', date_structure: '%Y/%m/%d' },
                { first_date: '2012-02-02', second_date: '2012-02-03' , format: 'YMD', date_structure: '%Y/%m/%d' },
                { first_date: '01/02/2015', second_date: '01/03/2015' , format: 'MDY', date_structure: '%m/%d/%Y' },
                { first_date: '01.02.2015', second_date: '01.03.2015' , format: 'MDY', date_structure: '%m/%d/%Y' },
                { first_date: '01-02-2015', second_date: '01-03-2015' , format: 'MDY', date_structure: '%m/%d/%Y' },
                { first_date: '01/03/2015', second_date: '02/03/2015' , format: 'DMY', date_structure: '%d/%m/%Y' },
                { first_date: '01.03.2015', second_date: '02.03.2015' , format: 'DMY', date_structure: '%d/%m/%Y' },
                { first_date: '01-03-2015', second_date: '02-03-2015' , format: 'DMY', date_structure: '%d/%m/%Y' } ]

      cases.each do |example|

        let(:first_date_to_date)  { DateTime.parse( example[:first_date], example[:date_structure]) }

        let(:second_date_to_date) { DateTime.parse( example[:second_date], example[:second_date]) }

        let(:format) { example[:format] }

        subject { DateManager.new( example[:first_date], example[:second_date], format ) }

        it 'sets a date object on @start_date' do
          expect( subject.start_date ).to eq( first_date_to_date )
        end

        it 'sets a date object on @finish_date' do
          expect( subject.finish_date ).to eq( second_date_to_date )
        end

        it 'sets the format' do
          expect( subject.format ).to eq( format )
        end

      end
    end

    context 'when no date format is given' do

      ymd_cases = [ { first_date: '2012/02/02', second_date: '2012/02/03', date_structure: '%Y/%m/%d' },
                    { first_date: '2012.02.02', second_date: '2012.02.03', date_structure: '%Y/%m/%d' },
                    { first_date: '2012-02-02', second_date: '2012-02-03', date_structure: '%Y/%m/%d' } ]

      context 'and the format dates have YMD format' do
        ymd_cases.each do |example|

          let(:first_date_to_date)  { DateTime.parse( example[:first_date], example[:date_structure]) }

          let(:second_date_to_date) { DateTime.parse( example[:second_date], example[:second_date]) }

          subject { DateManager.new( example[:first_date], example[:second_date] ) }

          it 'only allow date strings with YMD format' do
            expect( subject.start_date ).to eq( first_date_to_date )
          end

          it 'sets format to YMD' do
            expect( subject.format ).to eq( 'YMD' )
          end

        end
      end

    end

    context 'and the format dates are not YMD' do
      cases = [ { first_date: '01/02/2015', second_date: '01/03/2015' , date_structure: '%m/%d/%Y' },
                { first_date: '01.02.2015', second_date: '01.03.2015' , date_structure: '%m/%d/%Y' },
                { first_date: '01-02-2015', second_date: '01-03-2015' , date_structure: '%m/%d/%Y' },
                { first_date: '01/03/2015', second_date: '02/03/2015' , date_structure: '%d/%m/%Y' },
                { first_date: '01.03.2015', second_date: '02.03.2015' , date_structure: '%d/%m/%Y' },
                { first_date: '01-03-2015', second_date: '02-03-2015' , date_structure: '%d/%m/%Y' } ]

      cases.each do |ymd|

        subject { DateManager.new( ymd[:first_date], ymd[:second_date] ) }

        it 'does not allow to set an object when no format is given and the date format is not YMD' do
          expect( subject.start_date ).to  eq( nil )
          expect( subject.finish_date ).to eq( nil )
        end

      end
    end

  end

  describe '#valid_date_range?' do

    context 'when the first date is smaller than the second date' do
      it 'the result is true' do
        expect( DateManager.new( '01/02/2015', '01/03/2015', 'DMY' ).valid_date_range? ).to be true
      end
    end

    context 'when the first date is bigger than the second date' do
      it 'the result is true' do
        expect( DateManager.new( '02/03/2015', '01/03/2015', 'DMY' ).valid_date_range? ).to be false
      end
    end

  end

  describe '#days_between_dates' do

    context 'with start date "01/02/2015" and finish date 01/03/2015' do
      it 'the result is 28' do
        expect( DateManager.new( '01/02/2015', '01/03/2015', 'DMY' ).days_between_dates ).to eq(28)
      end
    end

    context 'without a valid date range' do
      it 'the result is nil' do
        expect( DateManager.new( '02/03/2015', '01/03/2015', 'DMY' ).days_between_dates ).to eq(nil)
      end
    end

  end

  describe '#months_between_dates' do

    cases = [ { first_date: '01/02/2015', second_date: '01/03/2015' , expected_result: 1 },
              { first_date: '01/02/2015', second_date: '02/02/2015' , expected_result: 0 },
              { first_date: '01/12/2014', second_date: '02/12/2015' , expected_result: 12 },
              { first_date: '02/03/2015', second_date: '01/03/2015' , expected_result: nil },
              { first_date: '01/02/2015', second_date: '01/02/2015' , expected_result: nil } ]

    context 'based on the above inputs' do
      cases.each do |ymd|
        it 'the result is #{ymd[:expected_result]}' do
          expect( DateManager.new( ymd[:first_date], ymd[:second_date], 'DMY' ).months_between_dates ).to eq(ymd[:expected_result])
        end
      end
    end

  end

  describe '#years_between_dates' do

    cases = [ { first_date: '01/02/2015', second_date: '01/03/2015' , expected_result: 0 },
              { first_date: '01/02/2015', second_date: '02/02/2015' , expected_result: 0 },
              { first_date: '01/12/2014', second_date: '02/12/2015' , expected_result: 1 },
              { first_date: '02/03/2015', second_date: '01/03/2015' , expected_result: nil },
              { first_date: '01/02/2015', second_date: '01/02/2015' , expected_result: nil } ]

    context 'based on the above inputs' do
      cases.each do |ymd|
        it 'the result is #{ymd[:expected_result]}' do
          expect( DateManager.new( ymd[:first_date], ymd[:second_date], 'DMY' ).years_between_dates ).to eq(ymd[:expected_result])
        end
      end
    end

  end

  describe '#differences_between_dates' do

    context 'with start date "01/02/2015" and finish date 01/03/2015' do
      it 'returns an array like {years: 0, months: 1, days: 28}' do
        expect( DateManager.new( '01/02/2015', '01/03/2015', 'DMY' ).differences_between_dates ).to eq({years: 0, months: 1, days: 28})
      end
    end

    context 'with start date "01/12/2014" and finish date 02/12/2015' do
      it 'returns an array like {years: 1, months: 12, days: 366}' do
        expect( DateManager.new( '01/12/2014', '02/12/2015', 'DMY' ).differences_between_dates ).to eq({years: 1, months: 12, days: 366})
      end
    end

  end

  describe '#start_date_leap_year?' do
    context 'with start date "01/12/2016" and finish date 02/12/2020' do
      it 'returns true - 2016 is a leap year' do
        expect( DateManager.new( '01/12/2016', '02/12/2020', 'DMY' ).start_date_leap_year? ).to be true
      end

      it 'returns false - 2015 is not a leap year' do
        expect( DateManager.new( '01/12/2015', '02/12/2020', 'DMY' ).start_date_leap_year? ).to be false
      end
    end
  end

  describe '#start_date_leap_year?' do
    context 'with start date "01/12/2016" and finish date 02/12/2020' do
      it 'returns true - 2020 is a leap year' do
        expect( DateManager.new( '01/12/2015', '02/12/2020', 'DMY' ).finish_date_leap_year? ).to be true
      end

      it 'returns false - 2015 is not a leap year' do
        expect( DateManager.new( '01/12/2015', '02/12/2015', 'DMY' ).finish_date_leap_year? ).to be false
      end
    end
  end

  describe '#human_readable_format' do
    context 'with start date "01/12/2016" and finish date 02/12/2020' do
      it 'returns -> "Date range between February 02, 2012 Thursday and February 03, 2012 Friday" ' do
        expected_string = "First date : February 02, 2012 Thursday - Second date : February 03, 2012 Friday"
        expect( DateManager.new( '2012/02/02', '2012/02/03' ).human_readable_format ).to eq(expected_string)
      end
    end
  end

  describe '#readable_days_between_dates' do
    context 'with start date "2012/02/02" and finish date 2012/02/03' do
      it 'returns -> "2 days" ' do
        expected_string = "2 days"
        expect( DateManager.new( '2012/02/01', '2012/02/03' ).readable_days_between_dates ).to eq(expected_string)
      end
    end
  end

  describe '#readable_months_between_dates' do
    context 'with start date "2012/02/02" and finish date 2012/02/03' do
      it 'returns -> "0 months" ' do
        expected_string = "0 months"
        expect( DateManager.new( '2012/02/01', '2012/02/03' ).readable_months_between_dates ).to eq(expected_string)
      end
    end
  end

  describe '#working_days' do
    context 'with start date "2015/02/01" and finish date 2015/02/03' do
      it 'returns 2 - First date is sunday and second tuesday' do
        expect( DateManager.new( '2015/02/01', '2015/02/03' ).working_days ).to eq(2)
      end
    end

    context 'with start date "2015/02/02" and finish date 2015/02/16' do
      it 'returns 11 - First date is monday and second monday two weeks after' do
        expect( DateManager.new( '2015/02/02', '2015/02/16' ).working_days ).to eq(11)
      end
    end

    context 'with start date "2015/02/04" and finish date 2015/02/05' do
      it 'returns 0 - First date is saturday and second sunday' do
        expect( DateManager.new( '2015/04/04', '2015/04/05' ).working_days ).to eq(0)
      end
    end

  end

  describe '#total_weekend_days' do
    context 'with start date "2015/02/01" and finish date 2015/02/03' do
      it 'returns 1 - 1st February 2015 is sunday - 5th February is Thursday' do
        expect( DateManager.new( '2015/02/01', '2015/02/03' ).total_weekend_days ).to eq(1)
      end

      it 'returns 4 - 2 weekends between these dates' do
        expect( DateManager.new( '2015/01/30', '2015/02/13' ).total_weekend_days ).to eq(4)
      end
    end
  end
end