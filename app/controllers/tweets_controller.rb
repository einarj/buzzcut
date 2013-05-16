class TweetsController < ApplicationController

  def update_all
    # If last tweet is old enough, get new tweets since then
    # Expire too old tweets

    link = Link.first
    home_timeline.each do |t|
      begin
        if Tweet.where(:tweet_id => t.id).count == 0
          tweet = Tweet.create!(:tweet_id => t.id, :published_on => t.created_at, :user => t.user.to_hash, :full_text => t.full_text)
          t.urls.each do |u|
            tweet_url = TweetUrl.create!(u.attrs)

            link = Link.find_or_create_by(url: tweet_url.expanded_url)
            link.tweets << tweet
            link.save

            tweet_url.link = link
            tweet_url.tweet = tweet
          end
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
