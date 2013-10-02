class Link
  include Mongoid::Document

  has_many :tweet_urls
  has_and_belongs_to_many :tweets

  validates_presence_of :url

  before_update :update_tweet_count

  field :url
  field :tweet_count, :type => Integer

  index({ url: 1 }, { unique: true, name: "url_index" })


  def update_tweet_count
    self.tweet_count = self.tweets.count
  end

end
