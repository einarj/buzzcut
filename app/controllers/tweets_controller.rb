class TweetsController < ApplicationController

  def update_all
    # If last tweet is old enough, get new tweets since then
    # Expire too old tweets

    link = Link.first
    home_timeline.each do |t|
      begin
        #tweet = Tweet.create!(:published_on => t.created_at, :content => Crack::JSON.parse(t.to_json))
        #tweet = Tweet.create!(:published_on => t.created_at, :user => t.user.to_hash, :full_text => t.full_text, :urls => t.urls)
        tweet = Tweet.create!(:published_on => t.created_at, :user => t.user.to_hash, :full_text => t.full_text)
        #link.tweets << tweet
        t.urls.each do |u|
          tweet_url = TweetUrl.create!(u.attrs)
          # Find or create link
          link = Link.find_or_create_by(url: tweet_url.expanded_url)
          # Add Tweet to link
          link.tweets << tweet
          # Add TweetUrl to link
          tweet_url.link = link
          tweet_url.tweet = tweet
        end
      rescue Exception => e
        debugger
        p e
      end
    end

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
