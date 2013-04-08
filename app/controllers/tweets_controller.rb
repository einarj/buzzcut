class TweetsController < ApplicationController

  def update_all
    # If last tweet is old enough, get new tweets since then
    # Expire too old tweets

    link = Link.first
    home_timeline.each do |t|
      tweet = Tweet.create!(:published_on => t.created_at, :content => Crack::JSON.parse(t.to_json))
      link.tweets << tweet
    end

    respond_to do |format|
      format.js
    end


  end

  private

  def home_timeline
    client.home_timeline
  end

  def client
    Twitter::Client.new(:oauth_token => session[:oauth_token], :oauth_token_secret => session[:oauth_token_secret])
  end
end
