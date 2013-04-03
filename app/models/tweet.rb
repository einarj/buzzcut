class Tweet
  include Mongoid::Document
  field :published_on, :type => Date
  field :content

  has_and_belongs_to_many :links
end
