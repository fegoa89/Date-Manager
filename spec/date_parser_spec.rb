require 'date_manager'

describe DateParser do

  describe '#initialize' do

      context 'with a valid date_format given' do

        DateParser::DATE_FORMAT.each do |format|
          it '#{format} gets set' do
            expect( DateParser.new('', '', format).format ).to eq(format)
          end

          it '#{format} gets set if it is in a lowercase' do
            expect( DateParser.new('', '', format.downcase).format ).to eq(format)
          end

        end
      end

      context 'with a wrong date_format given' do

        context 'if date_format is not present' do
          it 'is set to YMD' do
            expect( DateParser.new('', '').format ).to eq('YMD')
          end
        end

        context 'if date_format is empty' do
          it 'is set to YMD' do
            expect( DateParser.new('', '', '').format ).to eq('YMD')
          end
        end

        context 'if date_format is nil' do
          it 'is set to YMD' do
            expect( DateParser.new('', '', '').format ).to eq('YMD')
          end
        end

        context 'if date_format given is not correct' do
          it 'is set to nil' do
            expect( DateParser.new('', '', 'whatever').format ).to eq(nil)
          end
        end

      end

  end

  describe '#parse' do

    context 'with a valid start date and finish date' do
      context 'and a wrong date_format given' do
        it 'returns nil' do
          expect( DateParser.new( '02/03/2015', '03/03/2015', nil).parse ).to eq(nil)
        end
      end

      context 'and valid YMD dates' do

        context 'with valid params given' do
          ymd_cases = [ { first_date: '2012/02/02', second_date: '2012/02/03' , format: 'YMD', date_structure: '%Y/%m/%d' },
                        { first_date: '2012.02.02', second_date: '2012.02.03' , format: 'YMD', date_structure: '%Y/%m/%d' },
                        { first_date: '2012-02-02', second_date: '2012-02-03' , format: 'YMD', date_structure: '%Y/%m/%d' } ]

          ymd_cases.each do |ymd|

            let(:result_objects_array) { [ DateTime.parse( ymd[:first_date], ymd[:date_structure]), DateTime.parse( ymd[:second_date], ymd[:date_structure]) ] }

            it 'returns 2 Date objects for YMD format' do
              expect( DateParser.new( ymd[:first_date], ymd[:second_date], ymd[:format]).parse ).to eq(result_objects_array )
            end
          end
        end
      end

      context 'and valid MDY dates' do

        context 'with valid params given' do
          mdy_cases = [ { first_date: '01/02/2015', second_date: '01/03/2015' , format: 'MDY', date_structure: '%m/%d/%Y' },
                        { first_date: '01.02.2015', second_date: '01.03.2015' , format: 'MDY', date_structure: '%m/%d/%Y' },
                        { first_date: '01-02-2015', second_date: '01-03-2015' , format: 'MDY', date_structure: '%m/%d/%Y' } ]

          mdy_cases.each do |mdy|

            let(:result_objects_array) { [ DateTime.parse( mdy[:first_date], mdy[:date_structure]), DateTime.parse( mdy[:second_date], mdy[:date_structure]) ] }

            it 'returns 2 Date objects for YMD format' do
              expect( DateParser.new( mdy[:first_date], mdy[:second_date], mdy[:format]).parse ).to eq(result_objects_array )
            end
          end
        end
      end

    end

    context 'and valid DMY dates' do

        context 'with valid params given' do
          dmy_cases = [ { first_date: '01/03/2015', second_date: '02/03/2015' , format: 'DMY', date_structure: '%d/%m/%Y' },
                        { first_date: '01.03.2015', second_date: '02.03.2015' , format: 'DMY', date_structure: '%d/%m/%Y' },
                        { first_date: '01-03-2015', second_date: '02-03-2015' , format: 'DMY', date_structure: '%d/%m/%Y' } ]

          dmy_cases.each do |dmy|

            let(:result_objects_array) { [ DateTime.parse( dmy[:first_date], dmy[:date_structure]), DateTime.parse( dmy[:second_date], dmy[:date_structure]) ] }

            it 'returns 2 Date objects for YMD format' do
              expect( DateParser.new( dmy[:first_date], dmy[:second_date], dmy[:format]).parse ).to eq(result_objects_array )
            end
          end
        end
    end
  end

end