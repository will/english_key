require 'spec_helper'
include EnglishKey

describe RFC1751, "WORDS" do
  subject { RFC1751::WORDS }
  its(:size) { should == 2048 }
  its(:first){ should == 'A' }
  its(:last) { should == 'YOKE' }
  it { should be_all {|word| word =~ /\A[A-Z]+\z/ } }
end

describe RFC1751, 'encode / decode' do
  examples = {
    0xEB33F77EE73D4053                 => 'TIDE ITCH SLOW REIN RULE MOT',
    0x47414c26fde000ab                 => 'YOU CAN BUY WILL A BEER',
    0xCCAC2AED591056BE4F90FD441C534766 => 'RASH BUSH MILK LOOK BAD BRIM AVID GAFF BAIT ROT POD LOVE',
    0xEFF81F9BFBC65350920CDD7416DE8009 => 'TROD MUTE TAIL WARM CHAR KONG HAAG CITY BORE O TEAL AWL'
  }

  describe '.encode' do
    examples.each do |hex, str|
      it "encodes 0x#{hex.to_s(16).upcase} correctly" do
        RFC1751.encode(hex).should == str
      end
    end
  end

  describe '.decode' do
    examples.each do |hex, str|
      it "decodes '#{str}' correctly" do
        RFC1751.decode(str).should == hex
      end
    end

    it 'is stable' do
      ok_phrase = 'YOU CAN BUY WILL A CAT'
      RFC1751.encode(RFC1751.decode(ok_phrase)).should == ok_phrase
    end

    it 'detects checksum errors' do
      bad_phrase = 'YOU CAN BUY WILL A CAR'
      expect{ RFC1751.decode(bad_phrase) }.to raise_error(RFC1751::ChecksumError)
    end
  end
end

