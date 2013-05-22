class TweetsController < ApplicationController

  MAX_ATTEMPTS = 3

  def update_all
    # If last tweet is old enough, get new tweets since then
    # Expire too old tweets

    link = Link.first
    num_attempts = 0
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
      rescue Twitter::Error::TooManyRequests => error
        if num_attempts <= MAX_ATTEMPTS
          # NOTE: Your process could go to sleep for up to 15 minutes but if you
          #     # retry any sooner, it will almost certainly fail with the same exception.
          sleep error.rate_limit.reset_in
          retry
        else
          raise
        end
      rescue Exception => e
        debugger
        p e
      end
    end

    report_rate_limit

    respond_to do |format|
      format.js
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  private

  def home_timeline
    oldest = Tweet.asc(:published_on).first
    if oldest && oldest.published_on >= 30.days.ago.to_date
      # This should only be required during an initialization period
      p "FETCHING OLDER THAN #{Tweet.min(:tweet_id)}"
      client.home_timeline(:count => 200, :max_id => Tweet.min(:tweet_id))
    elsif oldest.nil? # Initializing
      client.home_timeline(:count => 200)
    else
      p "FETCHING NEWER THAN #{Tweet.max(:tweet_id)}"
      client.home_timeline(:count => 200, :since_id => Tweet.max(:tweet_id))
    end


  end

  def client
    Twitter::Client.new(:oauth_token => session[:oauth_token], :oauth_token_secret => session[:oauth_token_secret])
  end

  def report_rate_limit
    rate_limit = Twitter::RateLimit.new
    p """
    ################################################
    # RATE LIMIT STATUS
    # LIMIT: #{rate_limit.limit}
    # REMAINING: #{rate_limit.remaining}
    # RESET_AT: #{rate_limit.reset_at}
    # RESET_IN: #{rate_limit.reset_in} seconds
    ################################################
    """
  end
end
