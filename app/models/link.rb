class Link
  include Mongoid::Document
  field :url

  has_and_belongs_to_many :tweets
  index({ url: 1 }, { unique: true, name: "url_index" })
end