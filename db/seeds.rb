# roles
admin_role = Role.find_or_create_by!(token: "admin") { |r| r.name = "Administrateur" }
vendor_role = Role.find_or_create_by!(token: "vendor") { |r| r.name = "Vendeur" }
customer_role = Role.find_or_create_by!(token: "customer") { |r| r.name = "Client" }

# societe
ville = Ville.first || Ville.create!(name: "Douala", code: "DLA")
societe = Societe.find_or_create_by!(name: "3C Cameroun") do |s|
  s.phone = "600000000"
  s.email = "contact@3ccameroun.cm"
  s.ville = ville
end

# users
User.find_or_create_by!(email: "admin@m.com") do |u|
  u.password = "123456"
  u.password_confirmation = "123456"
  u.name = "Admin"
  u.role = admin_role
  u.societe = societe
end

User.find_or_create_by!(email: "vendor@m.com") do |u|
  u.password = "123456"
  u.password_confirmation = "123456"
  u.name = "Vendor"
  u.role = vendor_role
  u.societe = societe
end

puts "Seeds created successfully with Admin and Vendor users."
