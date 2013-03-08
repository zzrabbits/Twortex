require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Tweets.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Tweets.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to tweets_url
  end
end
