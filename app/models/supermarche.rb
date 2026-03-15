class Supermarche < ApplicationRecord
  belongs_to :ville
  belongs_to :societe, optional: true
  belongs_to :user, optional: true
  has_many :liste_de_prix, dependent: :destroy
  has_many :liste_de_prix_items, through: :liste_de_prix
  has_one_attached :logo

  STATUSES = ["Pending", "Actif", "Suspendu", "Archivé"].freeze
  validates :status, inclusion: { in: STATUSES }

  before_validation :set_default_status, on: :create
  before_validation :generate_code, on: :create

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.address_changed? }

  def full_address
    [lieu_dit, quartier, ville&.name].compact.join(", ")
  end

  def address_changed?
    lieu_dit_changed? || quartier_changed? || ville_id_changed?
  end

  def self.to_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet(name: "Supermarches")
    
    headers = ["ID", "Nom", "Code", "Email", "Phone", "Ville", "Quartier", "Lieu-dit", "Latitude", "Longitude"]
    sheet.row(0).concat headers
    
    all.each_with_index do |supermarch, index|
      sheet.row(index + 1).replace [
        supermarch.id,
        supermarch.name,
        supermarch.code,
        supermarch.email,
        supermarch.phone,
        supermarch.ville&.name,
        supermarch.quartier,
        supermarch.lieu_dit,
        supermarch.latitude,
        supermarch.longitude
      ]
    end
    
    blob = StringIO.new
    book.write blob
    blob.string
  end

  def self.import(file)
    spreadsheet = Spreadsheet.open(file.path)
    sheet = spreadsheet.worksheet(0)
    
    # Skip header
    (1..sheet.last_row_index).each do |i|
      row = sheet.row(i)
      name = row[1]
      next if name.blank?
      
      ville = Ville.find_by(name: row[5])
      
      supermarche = find_by(id: row[0]) || new
      supermarche.attributes = {
        name: name,
        code: row[2],
        email: row[3],
        phone: row[4],
        ville: ville,
        quartier: row[6],
        lieu_dit: row[7],
        latitude: row[8],
        longitude: row[9]
      }
      supermarche.save!
    end
  end

  private

  def set_default_status
    self.status ||= "Pending"
  end

  def generate_code
    self.code = SecureRandom.hex(5).upcase if self.code.blank?
  end
end
