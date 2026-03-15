json.extract! terminal_access, :id, :ip_address, :country, :url, :user_agent, :blocked, :created_at, :updated_at
json.url terminal_access_url(terminal_access, format: :json)
