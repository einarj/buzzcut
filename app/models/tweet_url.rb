class TweetUrl
  include Mongoid::Document
  field :url, type: String
  field :expaned_url, type: String
  field :display_url, type: String

  belongs_to :link
  belongs_to :tweet
end
