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

end