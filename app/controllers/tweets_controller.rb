class TweetsController < ApplicationController

  MAX_ATTEMPTS = 3

  def update_all
    # If last tweet is old enough, get new tweets since then
    # Expire too old tweets

    link = Link.first
    num_attempts = 0
    gateway = TwitterGatewayService.new
    gateway.home_timeline.each do |t|
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

end
