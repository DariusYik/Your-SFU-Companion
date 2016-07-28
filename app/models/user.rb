class User < ActiveRecord::Base
    
    has_secure_password
    has_many :messages
    has_many :comments
    has_and_belongs_to_many :courses
    
end
