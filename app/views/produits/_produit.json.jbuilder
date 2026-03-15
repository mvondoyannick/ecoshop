json.extract! produit, :id, :name, :category, :udm, :udm_value, :created_at, :updated_at
json.url produit_url(produit, format: :json)
