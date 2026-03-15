class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_blocked_terminal
  before_action :track_terminal_access
  layout :layout_by_resource

  private

  def check_blocked_terminal
    # Exempt terminal_accesses controller so admins can unblock
    return if params[:controller] == "terminal_accesses"
    
    if TerminalAccess.where(ip_address: request.remote_ip, blocked: true).exists?
      render file: "public/403.html", status: :forbidden, layout: false
    end
  end

  def track_terminal_access
    # Skip tracking for terminal_accesses controller to avoid noise
    return if params[:controller] == "terminal_accesses"
    
    ua = request.user_agent
    client = DeviceDetector.new(ua)
    
    TerminalAccess.create(
      ip_address: request.remote_ip,
      user_agent: ua,
      url: request.original_url,
      country: session[:country] ||= fetch_country(request.remote_ip),
      blocked: TerminalAccess.where(ip_address: request.remote_ip, blocked: true).exists?,
      device_brand: client.device_brand,
      device_model: client.device_name, # device_name in device_detector is often the model
      device_type: client.device_type
    )
  end

  def fetch_country(ip)
    return "Local" if ip == "127.0.0.1" || ip == "::1"
    begin
      results = Geocoder.search(ip)
      results.first&.country || "Inconnu"
    rescue
      "Inconnu"
    end
  end

  def layout_by_resource
    if devise_controller?
      "auth"
    else
      "application"
    end
  end
end
