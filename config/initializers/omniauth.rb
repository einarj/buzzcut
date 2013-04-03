Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  puts "### INITIALIZING TWITTER WITH KEY: #{ ENV["BUZZCUT_TWITTER_CONSUMER_KEY"] }"
  provider :twitter, ENV["BUZZCUT_TWITTER_CONSUMER_KEY"], ENV["BUZZCUT_TWITTER_CONSUMER_SECRET"]
end
