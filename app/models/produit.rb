class Produit < ApplicationRecord
  belongs_to :societe, optional: true
  belongs_to :user, optional: true
  has_one_attached :image
  has_many :liste_de_prix_items, dependent: :destroy
  has_many :liste_de_prixes, through: :liste_de_prix_items

  scope :avec_reduction, -> { 
    joins(liste_de_prix_items: :liste_de_prix)
      .where(liste_de_prixes: { active: true })
      .where('liste_de_prix_items.discount > 0')
      .where('liste_de_prix_items.expiration_date > ? OR liste_de_prix_items.expiration_date IS NULL', Date.today)
      .distinct 
  }

  scope :expiration_proche, -> {
    joins(liste_de_prix_items: :liste_de_prix)
      .where(liste_de_prixes: { active: true })
      .where('liste_de_prix_items.expiration_date > ? AND liste_de_prix_items.expiration_date <= ?', Date.today, 15.days.from_now.to_date)
      .distinct
  }

  scope :non_perime, -> {
    joins(liste_de_prix_items: :liste_de_prix)
      .where(liste_de_prixes: { active: true })
      .where('liste_de_prix_items.expiration_date > ? OR liste_de_prix_items.expiration_date IS NULL', Date.today)
      .distinct
  }

  def perime?
    item = liste_de_prix_items.joins(:liste_de_prix).where(liste_de_prixes: { active: true }).order(created_at: :desc).first
    return false if item&.expiration_date.nil?
    item.expiration_date <= Date.today
  end

  def etat
    perime? ? "Périmé" : "Bon état"
  end

  validates :sku, uniqueness: true

  with_options if: :promotion? do
    validates :promotion_start_date, :promotion_end_date, :promotion_price, presence: true
  end

  before_validation :generate_sku, on: :create

  private

  def generate_sku
    return if sku.present?
    
    loop do
      self.sku = SecureRandom.hex(4).upcase
      break unless Produit.exists?(sku: sku)
    end
  end
end
