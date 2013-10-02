class UpdateFeedJob
  def self.queue; :app2; end

  def self.perform(oauth_token, oauth_token_secret)
    p "Updating tweets for oauth: #{oauth_token}, #{oauth_token_secret}"
    gateway = TwitterGateway.new(oauth_token, oauth_token_secret)
    feed_updater = FeedUpdater.new(gateway)
    feed_updater.update_all
    p "Feed updated"
  end

  def schedule(oauth_token, oauth_token_secret)
    #Resque.set_schedule "UpdateFeedJob", {every: "15s", class: "UpdateFeedJob", queue: "app2", args: {oauth_token: oauth_token, oauth_token_secret: oauth_token_secret} }
    Resque.set_schedule "UpdateFeedJob", {every: "15m", class: "UpdateFeedJob", queue: "app2", args: [oauth_token, oauth_token_secret] }
  end
end
