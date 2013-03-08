require 'test_helper'

class TweetsTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Tweets.new.valid?
  end
end
