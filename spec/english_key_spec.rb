require 'spec_helper'

describe EnglishKey, '.uuid' do
  let(:key) { EnglishKey.uuid }
  it 'generates different keys' do
    key2 = EnglishKey.uuid
    key.should_not == key2
  end

  it 'is a collection of words' do
    key.should =~ /\A\w+\z/
  end
end
