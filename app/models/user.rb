class User < ActiveRecord::Base
  
  has_secure_password  # a built-in method from ActiveRecord
  has_many :tweets

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find {|user| user.slug == slug}
  end

end
