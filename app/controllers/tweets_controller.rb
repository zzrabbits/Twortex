class TweetsController < ApplicationController
  def index
    #@keywords=["justintrudeau","martincauchon","nicholasherold3d","davidbertschi","marcgarneau","joycemurray","deborahcoyne","georgetakach","karenmccrimmon"]
    @array=[]
    @keywords=Cloud.get_keywords
    if(params.has_key?(:keyword) and !params.has_key?(:subkeyword))
      @cloud=Cloud.new
      @array=@cloud.query_keyword(params[:keyword])
      @selected_keyword=params[:keyword]
    elsif (params.has_key?(:subkeyword))
      @cloud=Cloud.new
      @array=@cloud.query_subkeyword(params[:subkeyword],params[:keyword])
      @selected_keyword=params[:keyword]
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(params[:tweet])
    if @tweet.save
      redirect_to tweets_url, :notice => "Successfully created tweet."
    else
      render :action => 'new'
    end
  end
end
