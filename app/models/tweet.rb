class Tweet
  include Mongoid::Document
  field :published_on, :type => Date
  field :user, :type => Hash
  field :full_text, :type => String
  field :urls, :type => Hash
  field :content, :type => Hash

  has_and_belongs_to_many :links
end
