class MainapiController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  
  respond_to :json
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  # GET /api/v1/supermarches
  def supermarches
    supermarches = Supermarche.includes(:ville, :liste_de_prix_items)
                               .where(status: 'Actif')
                               .order(:name)
    
    render json: supermarches.map { |supermarche| format_supermarche(supermarche) }
  end

  # GET /api/v1/produits_en_promotion
  def produits_en_promotion
    produits = Produit.avec_reduction.limit(20)
    
    result = produits.map do |produit|
      item = produit.liste_de_prix_items.joins(:liste_de_prix)
                    .where(liste_de_prixes: { active: true })
                    .where('liste_de_prix_items.discount > 0')
                    .where('liste_de_prix_items.expiration_date > ? OR liste_de_prix_items.expiration_date IS NULL', Date.today)
                    .order(created_at: :desc)
                    .first
      format_produit(item) if item
    end.compact

    render json: result
  end

  # GET /api/v1/produits_expiration_proche
  def produits_expiration_proche
    produits = Produit.expiration_proche.limit(20)
    
    result = produits.map do |produit|
      # On cherche le prix actif si disponible
      item = produit.liste_de_prix_items.joins(:liste_de_prix)
                    .where(liste_de_prixes: { active: true })
                    .order(created_at: :desc).first
      
      format_produit_with_optional_item(produit, item)
    end

    render json: result
  end

  # GET /api/v1/recherche?q=...
  def recherche
    query = params[:q].to_s.strip
    
    if query.blank?
      render json: []
      return
    end

    today = Date.today
    tomorrow = today + 1

    # Rechercher dans les items de liste de prix actifs, non périmés
    items = ListeDePrixItem.joins(:produit, liste_de_prix: :supermarche)
                          .where(liste_de_prixes: { active: true })
                          .where('COALESCE(liste_de_prix_items.expiration_date, ?) > ?', tomorrow, today)
                          .where('produits.name ILIKE ? OR produits.category ILIKE ? OR supermarches.name ILIKE ?', 
                                 "%#{query}%", "%#{query}%", "%#{query}%")
                          .limit(50)
                          .order('liste_de_prix_items.created_at DESC')

    render json: items.map { |item| format_produit(item) }
  end
  
  # GET /api/v1/supermarches/:id/produits
  def supermarche_produits
    supermarche = Supermarche.includes(
      liste_de_prix: { liste_de_prix_items: :produit }
    ).find(params[:id])
    
    # Get active price list or the most recent one
    liste_de_prix = supermarche.liste_de_prix.active.first || 
                    supermarche.liste_de_prix.order(created_at: :desc).first
    
    if liste_de_prix.nil?
      render json: {
        supermarche: format_supermarche(supermarche),
        produits: []
      }
      return
    end
    
    produits = liste_de_prix.liste_de_prix_items.map do |item|
      format_produit(item)
    end
    
    render json: {
      supermarche: format_supermarche(supermarche),
      liste_de_prix: {
        id: liste_de_prix.id,
        active: liste_de_prix.active,
        created_at: liste_de_prix.created_at
      },
      produits: produits
    }
  end
  
  private
  
  def format_supermarche(supermarche)
    {
      id: supermarche.id,
      nom: supermarche.name,
      logo: supermarche.logo.attached? ? url_for(supermarche.logo) : nil,
      localisation: {
        latitude: supermarche.latitude,
        longitude: supermarche.longitude,
        adresse: supermarche.full_address
      },
      nombre_produits: supermarche.liste_de_prix_items.count
    }
  end
  
  def format_produit(liste_de_prix_item)
    produit = liste_de_prix_item.produit
    supermarche = liste_de_prix_item.liste_de_prix.supermarche
    
    price = liste_de_prix_item.price.to_f
    discount = liste_de_prix_item.discount.to_f
    discount_type = liste_de_prix_item.discount_type
    
    final_price = price
    percentage = 0.0
    
    if discount > 0
      if discount_type == 'Pourcentage'
        percentage = discount
        final_price = price * (1 - discount / 100.0)
      elsif discount_type == 'Fixe'
        final_price = price - discount
        percentage = price > 0 ? (discount / price * 100.0) : 0
      end
    end

    {
      id: produit.id,
      nom: produit.name,
      sku: produit.sku,
      categorie: produit.category,
      udm: produit.udm,
      udm_value: produit.udm_value,
      image: produit.image.attached? ? url_for(produit.image) : nil,
      expiration_date: liste_de_prix_item.expiration_date,
      prix: {
        montant_initial: price,
        final_price: final_price.round(2),
        date_debut: liste_de_prix_item.start_date,
        date_fin: liste_de_prix_item.end_date
      },
      reduction: (discount > 0) ? {
        active: true,
        valeur: discount,
        type: discount_type,
        pourcentage_reduction: percentage.round(2),
        quantite_min: liste_de_prix_item.discount_quantity
      } : nil,
      supermarche: {
        id: supermarche.id,
        nom: supermarche.name,
        ville: supermarche.ville&.name
      },
      vente_en_gros: (produit.bulk_sale_quantity.present? && produit.bulk_sale_quantity > 0) ? {
        quantite_min: produit.bulk_sale_quantity,
        pourcentage_reduction: produit.bulk_sale_discount_percentage
      } : nil
    }
  end

  
  def format_produit_with_optional_item(produit, liste_de_prix_item = nil)
    if liste_de_prix_item
      format_produit(liste_de_prix_item)
    else
      {
        id: produit.id,
        nom: produit.name,
        sku: produit.sku,
        categorie: produit.category,
        udm: produit.udm,
        udm_value: produit.udm_value,
        image: produit.image.attached? ? url_for(produit.image) : nil,
        expiration_date: nil,
        prix: nil,
        reduction: nil,
        supermarche: nil,
        vente_en_gros: (produit.bulk_sale_quantity.present? && produit.bulk_sale_quantity > 0) ? {
          quantite_min: produit.bulk_sale_quantity,
          pourcentage_reduction: produit.bulk_sale_discount_percentage
        } : nil
      }
    end
  end

  def not_found
    render json: { error: 'Resource not found' }, status: :not_found
  end
end
