require 'spec_helper'
include EnglishKey

describe RFC1751, "WORDS" do
  it { RFC1751::WORDS.size.should == 2048 }
end
