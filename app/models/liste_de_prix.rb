class ListeDePrix < ApplicationRecord
  belongs_to :societe, optional: true
  belongs_to :user, optional: true
  belongs_to :supermarche
  has_many :liste_de_prix_items, dependent: :destroy
  accepts_nested_attributes_for :liste_de_prix_items, allow_destroy: true, reject_if: :all_blank

  scope :active, -> { where(active: true) }

  def activate!
    transaction do
      supermarche.liste_de_prix.update_all(active: false)
      update!(active: true)
    end
  end
end
