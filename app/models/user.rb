class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  VALID_LOGIN_REGEX = /\A[0-9_]*[a-z]+[0-9a-z_]*\Z/i
  validates :login, :presence => true,
                    :length => { :minimum => 2, :maximum => 16 },
                    :format => { :with => VALID_LOGIN_REGEX },
                    :uniqueness => { :case_sensitive => false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true,
                    :format => { :with => VALID_EMAIL_REGEX },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :length => { :minimum => 8 }

  has_secure_password
end
