class User < ApplicationRecord
    validates :email, presence: true, length: {maximum: 255}, uniqueness: true
end
