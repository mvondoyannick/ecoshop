json.extract! societe, :id, :name, :phone, :ville_id, :email, :created_at, :updated_at
json.url societe_url(societe, format: :json)
