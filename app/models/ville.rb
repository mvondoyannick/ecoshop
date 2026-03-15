class Ville < ApplicationRecord
  STATUSES = ["Planifiée", "Visitée", "Archivée"].freeze
  validates :status, inclusion: { in: STATUSES }
  has_many :supermarches, dependent: :destroy
end
