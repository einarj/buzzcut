class User
  include Mongoid::Document
  field :name, type: String

  attr_accessible :name
  attr_accessor :oauth_token, :oauth_token_secret

  validates_presence_of :name

  def self.find_or_create_from_auth_hash(auth_hash)
    info = auth_hash['info']
    name = info['name'] || info['email']

    find_or_create_by(name: name)
  end

  def self.find_by_remember_token(remember_token)
    find(remember_token)
  end
end
