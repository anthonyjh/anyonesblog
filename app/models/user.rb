class User < ActiveRecord::Base
   has_many :articles, dependent: :destroy  #whatever articles this user has, will be deleted upon destroy

   before_save {self.email = email.downcase } #before user hits database, it downcases the email and then saves to db
   
   validates :username, presence: true, uniqueness: { case_sensative: false },
            length: { minimum: 3, maximum: 25 } #ensures username is present
   
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
   validates :email, presence: true, length: {maximum: 105}, uniqueness: { case_sensative: false }, 
            format: { with: VALID_EMAIL_REGEX }
            
   has_secure_password
   
end