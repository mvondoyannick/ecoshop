class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  belongs_to :societe, optional: true

  has_many :supermarches, class_name: "Supermarche"
  has_many :produits
  has_many :liste_de_prixes

  def admin?
    role&.token == "admin"
  end

  def vendor?
    role&.token == "vendor"
  end
end
