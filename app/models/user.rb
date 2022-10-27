class User < ApplicationRecord
    validates :first_name, :last_name, :password_digest, presence: true
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "invalid email" }, presence: true

    has_secure_password

    has_many :todos, dependent: :destroy
end
