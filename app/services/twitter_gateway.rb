class TwitterGateway

  def initialize(oauth_token, oauth_token_secret)
    @oauth_token = oauth_token
    @oauth_token_secret = oauth_token_secret
  end

  def home_timeline(already_have_oldest=false)

    max_id = Tweet.max(:tweet_id)
    newest = Tweet.where(tweet_id: max_id).first

    if newest.nil?
      client.home_timeline(:count => 200)
    elsif newest.published_on <= 15.minutes.ago.to_date
      p "FETCHING NEWER THAN #{Tweet.max(:tweet_id)}"
      client.home_timeline(:count => 200, :since_id => max_id)
    end
  end

  def client
    Twitter::Client.new(oauth_hash)
  end

  def oauth_hash
    {oauth_token: @oauth_token, oauth_token_secret: @oauth_token_secret}
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
