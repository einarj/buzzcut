class Link
  include Mongoid::Document
  field :url

  has_many :tweet_urls
  has_and_belongs_to_many :tweets
  index({ url: 1 }, { unique: true, name: "url_index" })

  field :tweet_count, :type => Integer

  before_update :update_tweet_count

  def update_tweet_count
    self.tweet_count = self.tweets.count
  end

end
