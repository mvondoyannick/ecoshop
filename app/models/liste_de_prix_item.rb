class ListeDePrixItem < ApplicationRecord
  belongs_to :liste_de_prix
  belongs_to :produit

  # Alias temporarily to avoid 500 errors while server reloads renamed column
  alias_attribute :expiration_date, :prod_expiration_date if column_names.include?("prod_expiration_date")

  validates :price, :start_date, presence: true

  after_destroy :destroy_empty_parent_list

  def perime?
    return false if expiration_date.nil?
    expiration_date <= Date.today
  end

  def etat
    perime? ? "Périmé" : "Bon état"
  end

  private

  def destroy_empty_parent_list
    liste_de_prix.destroy if liste_de_prix.liste_de_prix_items.empty?
  end
end
