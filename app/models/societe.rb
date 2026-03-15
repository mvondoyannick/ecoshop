class Societe < ApplicationRecord
  belongs_to :ville
  has_one_attached :logo
  has_many :users
  has_many :supermarches
  has_many :produits
  has_many :liste_de_prixes
end
