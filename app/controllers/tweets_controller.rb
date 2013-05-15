class TweetsController < ApplicationController

  def update_all
    # If last tweet is old enough, get new tweets since then
    # Expire too old tweets

    link = Link.first
    home_timeline.each do |t|
      begin
        #tweet = Tweet.create!(:published_on => t.created_at, :content => Crack::JSON.parse(t.to_json))
        tweet = Tweet.create!(:published_on => t.created_at, :user => t.user, :full_text => t.full_text, :urls => t.urls)
        link.tweets << tweet
      rescue Exception => e
        debugger
        p e
      end
    end


    #home_timeline.each do |t|
      #t.urls.each do |url|
        #link = Link.create!(:url => url)
        #tweet = Tweet.create!(:published_on => t.created_at, :content => Crack::JSON.parse(t.to_json))
        #link.tweets << tweet
      #end
    #end

    respond_to do |format|
      format.js
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  private

  def home_timeline
    client.home_timeline
  end

  def client
    Twitter::Client.new(:oauth_token => session[:oauth_token], :oauth_token_secret => session[:oauth_token_secret])
  end
end
