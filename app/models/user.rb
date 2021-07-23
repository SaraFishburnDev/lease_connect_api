class User < ApplicationRecord
  belongs_to :house, optional: true

  has_and_belongs_to_many :properties, join_table: :houses_users, class_name: "House"

  has_secure_password

  def jwt_token
    JWT.encode({ id: id, role: role_name }, Rails.application.secrets.secret_key_base)
  end
end
