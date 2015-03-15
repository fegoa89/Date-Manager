require 'date_manager'

describe DateParser do

  describe '#initialize' do

    context 'setting the format' do

      context 'with a valid date_format given' do

        DateParser::DATE_FORMAT.each do |format|
          it '#{format} should get set' do
            expect( DateParser.new('', '', format).format ).to eq(format)
          end

          it '#{format.} should get set if it is in a lowercase' do
            expect( DateParser.new('', '', format.downcase).format ).to eq(format)
          end

        end
      end

      context 'if date_format is not present' do
        it 'should be set to YMD' do
          expect( DateParser.new('', '').format ).to eq('YMD')
        end
      end

      context 'if date_format is empty' do
        it 'should be set to YMD' do
          expect( DateParser.new('', '', '').format ).to eq('YMD')
        end
      end

      context 'if date_format is nil' do
        it 'should be set to YMD' do
          expect( DateParser.new('', '', '').format ).to eq('YMD')
        end
      end

      context 'if date_format given is not correct' do
        it 'should be set to nil' do
          expect( DateParser.new('', '', 'whatever').format ).to eq(nil)
        end
      end
    end
  end
end