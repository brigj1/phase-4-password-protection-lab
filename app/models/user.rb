class User < ApplicationRecord
    has_secure_password

    validates :password, presence: true
    #validates :password, allow_blank: false
    validates :password, length: { minimum: 1 }
    validates :password, confirmation: true
    #validates :password_confirmation, presence: true
end
