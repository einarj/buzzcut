class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String

  attr_accessible :name, :email
  attr_accessor :oauth_token, :oauth_token_secret

  validates_presence_of :name
  validates_presence_of :email

  def self.find_or_create_from_auth_hash(auth_hash)
    find_or_create_by creation_params(auth_hash['info'])
  end

  def self.find_by_remember_token(remember_token)
    find(remember_token)
  end


  private
    def self.extract_name(info)
      info['name'] || info['email']
    end

    def self.extract_email(info)
      info['email']
    end

    def self.creation_params(info)
      {
        name: extract_name(info),
        email: extract_email(info)
      }
    end
end
